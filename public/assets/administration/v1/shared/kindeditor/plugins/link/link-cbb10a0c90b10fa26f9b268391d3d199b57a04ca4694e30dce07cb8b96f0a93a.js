KindEditor.plugin("link",function(e){var l=this,i="link";l.plugin.link={edit:function(){var t=l.lang(i+"."),n='<div style="padding:20px;"><div class="ke-dialog-row"><label for="keUrl" style="width:60px;">'+t.url+'</label><input class="ke-input-text" type="text" id="keUrl" name="url" value="" style="width:260px;" /></div><div class="ke-dialog-row""><label for="keType" style="width:60px;">'+t.linkType+'</label><select id="keType" name="type"></select></div></div>',a=l.createDialog({name:i,width:450,title:l.lang(i),body:n,yesBtn:{name:l.lang("yes"),click:function(){var i=e.trim(c.val());if("//"==i||e.invalidUrl(i))return alert(l.lang("invalidUrl")),void c[0].focus();l.exec("createlink",i,o.val()).hideDialog().focus()}}}),d=a.div,c=e('input[name="url"]',d),o=e('select[name="type"]',d);c.val("//"),o[0].options[0]=new Option(t.newWindow,"_blank"),o[0].options[1]=new Option(t.selfWindow,""),l.cmd.selection();var r=l.plugin.getSelectedLink();r&&(l.cmd.range.selectNode(r[0]),l.cmd.select(),c.val(r.attr("data-ke-src")),o.val(r.attr("target"))),c[0].focus(),c[0].select()},"delete":function(){l.exec("unlink",null)}},l.clickToolbar(i,l.plugin.link.edit)});