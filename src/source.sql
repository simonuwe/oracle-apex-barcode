PROCEDURE render_barcode_field (
    p_item   IN apex_plugin.t_item, 
    p_plugin IN apex_plugin.t_plugin, 
    p_param  IN apex_plugin.t_item_render_param, 
    p_result IN OUT NOCOPY apex_plugin.t_item_render_result
) IS 
  l_code       BLOB; 
  l_scale      INTEGER        := p_item.attributes.get_number('scale');
  l_type       INTEGER        := p_item.attributes.get_number('type'); 
  l_typeitem   VARCHAR2(1000) := p_item.attributes.get_varchar2('typeitem'); 
  l_scaleitem  VARCHAR2(1000) := p_item.attributes.get_varchar2('scaleitem'); 
  l_quiet      NuMBER         := p_item.attributes.get_varchar2('quiet');
  l_foreground VARCHAR2(7)    := p_item.attributes.get_varchar2('foregroundcolor');
  l_background VARCHAR2(7)    := p_item.attributes.get_varchar2('backgroundcolor');
  l_eclevel    apex_barcode.t_eclevel_type:=p_item.attributes.get_varchar2('eclevel');
  l_value      p_param.value%TYPE := p_param.value;
BEGIN
  APEX_DEBUG.TRACE('BARCODE-PLUGIN: item: "%s" type: %d typeitem: "%s" scale: %d value: "%s"', p_item.name, l_type, l_typeitem, l_scale, l_value);
  IF(l_type=0) THEN -- the type is in a page-item, so get it
    l_type:=V(l_typeitem);
  END IF;
  IF(l_scale=0) THEN -- the type is in a page-item, so get it
    l_scale:=V(l_scaleitem);
  END IF;
  IF(l_value IS NOT NULL) THEN
    CASE l_type
      WHEN 1 THEN l_code:= APEX_BARCODE.GET_EAN8_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background);
      WHEN 2 THEN l_code:= APEX_BARCODE.GET_CODE128_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background);
      WHEN 3 THEN l_code:= APEX_BARCODE.GET_QRCODE_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background, p_quiet=>l_quiet, p_eclevel=>l_eclevel);
    END CASE;
    htp.p('<img id="' || p_item.name|| '" class="display_image apex-item-image" src="data:image/png;base64,'|| APEX_WEB_SERVICE.BLOB2CLOBBASE64(l_code) ||'"></img>');

      -- set the item as a display-image, so add class to item container
    APEX_JAVASCRIPT.ADD_ONLOAD_CODE (
      p_code => '$("#' ||p_item.name||'_CONTAINER").addClass("apex-item-wrapper--display-image");'
    );
  ELSE  -- Empty value, so no bar/QR-code
    htp.p('<div></div>');
  END IF;
  EXCEPTION WHEN OTHERS THEN
    htp.p('<div>Fatal barcode error</div>');
END render_barcode_field;
