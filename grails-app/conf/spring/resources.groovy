import org.springframework.web.servlet.i18n.FixedLocaleResolver

// Place your Spring DSL code here
beans = {
    localeResolver(FixedLocaleResolver) {
        defaultLocale = Locale.default
    }
}
