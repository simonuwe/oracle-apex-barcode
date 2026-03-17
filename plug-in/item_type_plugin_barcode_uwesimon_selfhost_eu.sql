prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.0'
,p_default_workspace_id=>74799088338073366
,p_default_application_id=>104
,p_default_id_offset=>0
,p_default_owner=>'TEST'
);
end;
/
 
prompt APPLICATION 104 - barcode-demo
--
-- Application Export:
--   Application:     104
--   Name:            barcode-demo
--   Date and Time:   19:09 Monday March 2, 2026
--   Exported By:     UWE
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 372520142174124782
--   Manifest End
--   Version:         24.2.0
--   Instance ID:     2363322565404831
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/barcode_uwesimon_selfhost_eu
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(372520142174124782)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'BARCODE.UWESIMON.SELFHOST.EU'
,p_display_name=>'barcode'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE render_barcode_field (',
'    p_item   IN apex_plugin.t_item, ',
'    p_plugin IN apex_plugin.t_plugin, ',
'    p_param  IN apex_plugin.t_item_render_param, ',
'    p_result IN OUT NOCOPY apex_plugin.t_item_render_result',
') IS ',
'  l_code       BLOB; ',
'  l_scale      INTEGER        := p_item.attributes.get_number(''scale'');',
'  l_type       INTEGER        := p_item.attributes.get_number(''type''); ',
'  l_typeitem   VARCHAR2(1000) := p_item.attributes.get_varchar2(''typeitem''); ',
'  l_scaleitem  VARCHAR2(1000) := p_item.attributes.get_varchar2(''scaleitem''); ',
'  l_quiet      NuMBER         := p_item.attributes.get_varchar2(''quiet'');',
'  l_foreground VARCHAR2(7)    := p_item.attributes.get_varchar2(''foregroundcolor'');',
'  l_background VARCHAR2(7)    := p_item.attributes.get_varchar2(''backgroundcolor'');',
'  l_eclevel    apex_barcode.t_eclevel_type:=p_item.attributes.get_varchar2(''eclevel'');',
'  l_value      p_param.value%TYPE := p_param.value;',
'BEGIN',
'  APEX_DEBUG.TRACE(''BARCODE-PLUGIN: item: "%s" type: %d typeitem: "%s" scale: %d value: "%s"'', p_item.name, l_type, l_typeitem, l_scale, l_value);',
'  IF(l_type=0) THEN -- the type is in a page-item, so get it',
'    l_type:=V(l_typeitem);',
'  END IF;',
'  IF(l_scale=0) THEN -- the type is in a page-item, so get it',
'    l_scale:=V(l_scaleitem);',
'  END IF;',
'  IF(l_value IS NOT NULL) THEN',
'    CASE l_type',
'      WHEN 1 THEN l_code:= APEX_BARCODE.GET_EAN8_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background);',
'      WHEN 2 THEN l_code:= APEX_BARCODE.GET_CODE128_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background);',
'      WHEN 3 THEN l_code:= APEX_BARCODE.GET_QRCODE_PNG(p_value=>l_value, p_scale=>l_scale, p_foreground_color=>l_foreground, p_background_color=>l_background, p_quiet=>l_quiet, p_eclevel=>l_eclevel);',
'    END CASE;',
'    htp.p(''<img id="'' || p_item.name|| ''" class="display_image apex-item-image" src="data:image/png;base64,''|| APEX_WEB_SERVICE.BLOB2CLOBBASE64(l_code) ||''"></img>'');',
'',
'      -- set the item as a display-image, so add class to item container',
'    APEX_JAVASCRIPT.ADD_ONLOAD_CODE (',
'      p_code => ''$("#'' ||p_item.name||''_CONTAINER").addClass("apex-item-wrapper--display-image");''',
'    );',
'  ELSE  -- Empty value, so no bar/QR-code',
'    htp.p(''<div></div>'');',
'  END IF;',
'  EXCEPTION WHEN OTHERS THEN',
'    htp.p(''<div>Fatal barcode error</div>'');',
'END render_barcode_field;'))
,p_api_version=>3
,p_render_function=>'render_barcode_field'
,p_standard_attributes=>'VISIBLE:FORM_ELEMENT:WIDTH:HEIGHT:ELEMENT_OPTION'
,p_substitute_attributes=>true
,p_version_scn=>121717186
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.2.0'
,p_about_url=>'https://github.com/simonuwe/oracle-apex-barcode'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(375521514850360338)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_static_id=>'type'
,p_prompt=>'Type'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'3'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(375522102955362447)
,p_plugin_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_display_sequence=>10
,p_display_value=>'EAN8'
,p_return_value=>'1'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(375522543444364174)
,p_plugin_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_display_sequence=>20
,p_display_value=>'Code128'
,p_return_value=>'2'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(375522889759365033)
,p_plugin_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_display_sequence=>30
,p_display_value=>'QR-Code'
,p_return_value=>'3'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390920282806881356)
,p_plugin_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_display_sequence=>40
,p_display_value=>'Type Item'
,p_return_value=>'0'
,p_help_text=>'A page item, with values 1,2 or 3 for EAN8, Code128 or QR-Code'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(390320163600732277)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_static_id=>'scale'
,p_prompt=>'Scale'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'5'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390320723978733310)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>10
,p_display_value=>'1'
,p_return_value=>'1'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390321117985734039)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>20
,p_display_value=>'2'
,p_return_value=>'2'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390321503497734944)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>30
,p_display_value=>'3'
,p_return_value=>'3'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390321952540735530)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>40
,p_display_value=>'4'
,p_return_value=>'4'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390322309474736100)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>50
,p_display_value=>'5'
,p_return_value=>'5'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390322757898736667)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>60
,p_display_value=>'6'
,p_return_value=>'6'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390323168218737314)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>70
,p_display_value=>'7'
,p_return_value=>'7'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390323480591739206)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>80
,p_display_value=>'8'
,p_return_value=>'8'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390323959106739657)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>90
,p_display_value=>'9'
,p_return_value=>'9'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(390324355453740495)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>100
,p_display_value=>'10'
,p_return_value=>'10'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(393920000791044876)
,p_plugin_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_display_sequence=>110
,p_display_value=>'Scale Item'
,p_return_value=>'0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(390720102348878076)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>15
,p_static_id=>'typeitem'
,p_prompt=>'Type-Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(394120076490053117)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>25
,p_static_id=>'scaleitem'
,p_prompt=>'Scale-Item'
,p_attribute_type=>'PAGE ITEM'
,p_is_required=>true
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(390320163600732277)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'0'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(207059956386264678)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_static_id=>'foregroundcolor'
,p_prompt=>'Foreground Color'
,p_attribute_type=>'COLOR'
,p_is_required=>true
,p_default_value=>'#000000'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(206260033852257212)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_static_id=>'backgroundcolor'
,p_prompt=>'Background Color'
,p_attribute_type=>'COLOR'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(207659958252277152)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_static_id=>'quiet'
,p_prompt=>'Quiet'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'1'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'0,3'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(207859919495280975)
,p_plugin_id=>wwv_flow_imp.id(372520142174124782)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_static_id=>'eclevel'
,p_prompt=>'EC-Level'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'H'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_imp.id(375521514850360338)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'IN_LIST'
,p_depending_on_expression=>'0,3'
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(209460304976362881)
,p_plugin_attribute_id=>wwv_flow_imp.id(207859919495280975)
,p_display_sequence=>10
,p_display_value=>'Low'
,p_return_value=>'L'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(209460774959364728)
,p_plugin_attribute_id=>wwv_flow_imp.id(207859919495280975)
,p_display_sequence=>20
,p_display_value=>'Medium'
,p_return_value=>'M'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(209461199780366546)
,p_plugin_attribute_id=>wwv_flow_imp.id(207859919495280975)
,p_display_sequence=>30
,p_display_value=>'Quartile'
,p_return_value=>'Q'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(209461519428367455)
,p_plugin_attribute_id=>wwv_flow_imp.id(207859919495280975)
,p_display_sequence=>40
,p_display_value=>'High'
,p_return_value=>'H'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
