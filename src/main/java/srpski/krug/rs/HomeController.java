package srpski.krug.rs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

/** Routes the public landing page to the Teamleaf template. */
@Controller
public class HomeController {

	@GetMapping({"/", })
	public String home1() {
		return "profilPage1";
	}

	@GetMapping({"/home2"})
	public String home2() {
		return "profilPage2";
	}

	/** Persist theme on server via cookie and redirect back. */
	@RequestMapping("/set-theme")
	public String setTheme(@RequestParam("theme") String theme,
						   @RequestParam(value = "redirect", required = false, defaultValue = "/") String redirect,
						   HttpServletResponse response) {
		Cookie c = new Cookie("APP_THEME", theme);
		c.setPath("/");
		c.setMaxAge(60 * 60 * 24 * 365); // 1 year
		response.addCookie(c);
		return "redirect:" + redirect;
	}
}
