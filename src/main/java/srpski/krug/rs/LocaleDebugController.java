package srpski.krug.rs;

import java.util.Locale;
import java.util.Map;

import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LocaleDebugController {

    private final MessageSource messageSource;

    public LocaleDebugController(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @GetMapping("/debug/locale")
    public Map<String, Object> locale(@RequestParam(value = "lang", required = false) String lang) {
        Locale locale = LocaleContextHolder.getLocale();
        // include language tag and resolved message for nav.network
        String navNetwork = messageSource.getMessage("nav.network", null, "MISSING: nav.network", locale);
        return Map.of(
            "locale", locale.toString(),
            "languageTag", locale.toLanguageTag(),
            "language", locale.getLanguage(),
            "script", locale.getScript(),
            "country", locale.getCountry(),
            "navNetwork", navNetwork
        );
    }
}
