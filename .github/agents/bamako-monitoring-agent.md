# Monitoring Agent Configuration

This document outlines the configuration and integration of monitoring tools (Splunk, Prometheus, and Grafana) for the Java Spring Boot microservice `sapmarketing-docstore`.

## Overview
The monitoring agent is responsible for ensuring that the microservice is observable and that metrics, logs, and alerts are properly configured and integrated with Splunk, Prometheus, and Grafana.

## Splunk Configuration
### Log Integration
1. **Logback Configuration**:
   - Ensure that the `logback-spring.xml` file is configured to send logs to Splunk.
   - Use the Splunk HTTP Event Collector (HEC) for log ingestion.
   - Example configuration:
     ```xml
     <appender name="SPLUNK" class="com.splunk.logging.HttpEventCollectorLogbackAppender">
         <url>https://splunk-url:8088</url>
         <token>your-splunk-token</token>
         <index>your-index</index>
         <source>sapmarketing-docstore</source>
         <sourcetype>_json</sourcetype>
     </appender>
     ```
2. **Environment Variables**:
   - Configure Splunk URL and token as environment variables.
   - Example:
     ```properties
     SPLUNK_URL=https://splunk-url:8088
     SPLUNK_TOKEN=your-splunk-token
     ```

## Prometheus Configuration
### Metrics Exporter
1. **Micrometer Integration**:
   - Add the `micrometer-registry-prometheus` dependency to `pom.xml`:
     ```xml
     <dependency>
         <groupId>io.micrometer</groupId>
         <artifactId>micrometer-registry-prometheus</artifactId>
     </dependency>
     ```
   - Ensure that the `management.endpoints.web.exposure.include` property includes `prometheus`:
     ```properties
     management.endpoints.web.exposure.include=prometheus
     ```
2. **Prometheus Scrape Configuration**:
   - Expose the `/actuator/prometheus` endpoint for Prometheus to scrape metrics.

## Grafana Configuration
### Dashboard Setup
1. **Import Prometheus Data Source**:
   - Configure Prometheus as a data source in Grafana.
   - Use the Prometheus endpoint URL (e.g., `http://prometheus-server:9090`).
2. **Create Dashboards**:
   - Import or create dashboards to visualize metrics from the microservice.
   - Recommended metrics:
     - HTTP request rates and latencies
     - JVM memory usage
     - Thread pool metrics

## Alerts
### Prometheus Alert Rules
1. **Define Alert Rules**:
   - Create alert rules in Prometheus for critical metrics.
   - Example rule:
     ```yaml
     groups:
     - name: sapmarketing-docstore-alerts
       rules:
       - alert: HighErrorRate
         expr: rate(http_server_requests_seconds_count{status!~"2.."}[5m]) > 0.05
         for: 2m
         labels:
           severity: warning
         annotations:
           summary: "High error rate detected"
           description: "{{ $labels.instance }} has a high error rate."
     ```

### Grafana Alerts
1. **Configure Alerts**:
   - Use Grafana's alerting feature to create notifications for critical metrics.
   - Example: Set up an alert for JVM memory usage exceeding a threshold.

## Validation
1. **Splunk**:
   - Verify that logs are being ingested into Splunk.
2. **Prometheus**:
   - Ensure that metrics are exposed at `/actuator/prometheus` and scraped by Prometheus.
3. **Grafana**:
   - Validate that dashboards display the expected metrics and alerts are triggered correctly.

## Notes
- Ensure that sensitive information (e.g., Splunk tokens) is not hardcoded and is managed securely using environment variables or a secrets manager.
- Follow the existing conventions and configurations in the repository for consistency.
