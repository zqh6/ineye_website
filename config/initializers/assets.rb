# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( mobile_test.css )

#Todo Maybe remove shared/editor/google-code-prettify/prettify.css
#Todo Maybe remove shared/bootstrap-wgsiwyg.js
Rails.application.config.assets.precompile += %w(
  swagger_engine/print.css
  swagger_engine/reset.css

  shared/jquery-2.1.4.min.js
  shared/amazeui.min.js
  shared/theme.js
  shared/amazeui_template1.js
  shared/amazeui.datatables.min.js
  shared/bootstrap-wgsiwyg.js
  shared/echarts.min.js
  shared/dataTables.responsive.min.js
  new/show.js
  administration/v1/shared/share.js
  administration/v1/shared/kindeditor/kindeditor.js
  administration/v1/shared/kindeditor/zh.js
  administration/v1/shared/amazeui.dialog.min
  administration/v1/shared/fileupload/jquery.ui.widget.js
  administration/v1/shared/fileupload/bootstrap-3.2.0.min.js
  administration/v1/shared/fileupload/jquery.iframe-transport.js
  administration/v1/shared/fileupload/jquery.fileupload.js
  administration/v1/shared/fileupload/jquery.fileupload-process.js
  administration/v1/shared/fileupload/jquery.fileupload-image.js
  administration/v1/shared/fileupload/jquery.fileupload-audio.js
  administration/v1/shared/fileupload/jquery.fileupload-video.js
  administration/v1/shared/fileupload/jquery.fileupload-validate.js
  administration/v1/shared/fileupload/jquery.fileupload-ui.js

  administration/v1/sessions/show.js
  administration/v1/sessions/new.js
  administration/v1/dashboards/show.js
  administration/v1/new/new.js
  administration/v1/new/index.js
  administration/v1/new/show.js
  administration/v1/users/new.js
  administration/v1/users/index.js
  administration/v1/passwords/show.js
  administration/v1/passwords/success.js
  administration/v1/new/edit.js
  administration/v1/comments/index.js
  administration/v1/office/index.js
  administration/v1/schedulings/scheduling.js
  administration/v1/leavings/leaving.js
  administration/v1/con_educations/new.js
  administration/v1/con_educations/index.js
  administration/v1/activity_enters/index.js

  shared/amazeui.min.css
  shared/amazeui.datatables.min.css
  shared/amazeui_template1.css.erb
  shared/editor/google-code-prettify/prettify.css
  new/show.css.erb
  administration/v1/shared/share.css
  administration/v1/shared/fileupload/blueimp-gallery.min.css
  administration/v1/shared/fileupload/bootstrap-3.2.0.min.css
  administration/v1/shared/fileupload/jquery.fileupload.css
  administration/v1/shared/fileupload/jquery.fileupload-ui.css
  administration/v1/shared/fileupload/fileupload-custom.css

  administration/v1/sessions/show.css
  administration/v1/sessions/new.css
  administration/v1/dashboards/show.css
  administration/v1/new/new.css
  administration/v1/new/index.css
  administration/v1/new/show.css
  administration/v1/users/new.css
  administration/v1/users/index.css
  administration/v1/passwords/edit.css
  administration/v1/new/edit.css
  administration/v1/passwords/show.css
  administration/v1/schedulings/scheduling.css
  administration/v1/leavings/new.css
  administration/v1/con_educations/new.css
  administration/v1/con_educations/index.css


  shared/browser_tab_title.ico
  shared/logo.png
  shared/portrait.png

  font/fontawesome-webfont.eot
  font/fontawesome-webfont.woff2
  font/fontawesome-webfont.woff
  font/fontawesome-webfont.ttf

  news/list/新闻列表.css.erb
  news/newsContent.css

  registerss.css

  mobile_test.css
  index_slide.js
  slide-2.js
  jquery.jDiaporama.js
  kindeditor.js
  baguetteBox.min.js
  video.min.js
  video-js.css
  edu_example.js
  videoon.js

  pdfjs/debugger.js
  pdfjs/viewer.js
  pdfjs/pdf.js
  pdfjs/pdf.worker.js
  pdfjs/l10n.js
  pdfjs/compatibility.js
  viewer.css
  wangEditor.js

  find_passwords/check_phone_number.js
  find_passwords/set_new_password.js

  logins/index.js

  smileface.png
)
