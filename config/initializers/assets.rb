# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )


#Todo Maybe remove shared/editor/google-code-prettify/prettify.css
#Todo Maybe remove shared/bootstrap-wgsiwyg.js
Rails.application.config.assets.precompile += %w(

    shared/jquery-2.1.4.min.js
    shared/amazeui.min.js
    shared/theme.js
    shared/amazeui_template1.js
    shared/bootstrap-wgsiwyg.js
    news/new.js
    administration/v1/sessions/new.js

    shared/amazeui.min.css
    shared/amazeui.datatables.min.css
    shared/amazeui_template1.css.erb
    shared/editor/google-code-prettify/prettify.css
    news/new.css.erb
    administration/v1/sessions/new.css.erb

    shared/browser_tab_title.ico
    shared/logo.png

)
