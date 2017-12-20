-- -------------------------------------------------------------------------------------
-- EDQ Meta Data for EC11 view changes
-- -------------------------------------------------------------------------------------
update pdm.edq_view_catalog
  set view_name = 'PDM_PHD_REVISIONS_JN'
where view_name = 'pdm_phd_revisions_jn' ;
 
update pdm.edq_view_catalog
  set view_name = 'PDM_WELL_REVISIONS_JN'
where view_name = 'pdm_well_revisions_jn' ;
 
-- -------------------------------------------------------------------------------------
-- New Commodity Summary View
-- -------------------------------------------------------------------------------------
insert into PDM.EDQ_VIEW_CATALOG(ID,VIEW_NAME,FRIENDLY_NAME,OUTPUT_STYLE,SCHEMA,DISABLED,REPORTING_GROUP)
values(128,'PDM_COMMODITY_SUMMARY','Cenovus - Commodity Summary','QUERY','EC',0,'Cenovus');
 
-- -------------------------------------------------------------------------------------
-- Default Columns
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Property', 1 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Production Date', 2 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Bitumen Alloc Net Vol m3', 3 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Steam Alloc Vol m3', 4 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Water Alloc Vol m3', 5 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'SOR', 6 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'WOR', 7 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'BFW Conv m3', 8 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'BFW CoGen m3', 9 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'BFW Total m3', 10 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Steam CoGen', 11 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Steam Conv', 12 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'CoGen Power MWHR', 13 ) ;
-- -Summable Columns--------------------------------------------------------------------
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'Bitumen Alloc Net Vol m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'Steam Alloc Vol m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'Water Alloc Vol m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'BFW Conv m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'BFW CoGen m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'BFW Total m3', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'Steam CoGen', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'Steam Conv', 'SUM' ) ;
 
insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
                           values ( 128, 'CoGen Power MWHR', 'SUM' ) ;
 
-- -------------------------------------------------------------------------------------
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_COMMODITY_SUMMARY', 'Production Date',   'DT' ) ;
 
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_COMMODITY_SUMMARY', 'Facility Id', 'HR' ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns
-- -------------------------------------------------------------------------------------
update pdm.edq_view_default_cols
  set column_name = 'Property'
where view_catalog_id >= 101 and view_catalog_id <= 299 
and   column_name = 'Facility Area' ;
 
update pdm.edq_view_default_cols
  set sort_order = 11
where view_catalog_id = 110
and   column_name = 'Project Phase' ;
 
update pdm.edq_view_default_cols
  set sort_order = 10
where view_catalog_id = 110
and   column_name = 'Regulatory Code' ;
 
insert into pdm.edq_view_default_cols 
       ( view_catalog_id, column_name, sort_order )
values ( 110, 'Calculation Category', 8) ;
 
insert into pdm.edq_view_default_cols 
       ( view_catalog_id, column_name, sort_order )
values ( 110, 'Balancing Group', 9) ;
 
update pdm.edq_view_default_cols
  set sort_order = 11
where view_catalog_id = 112
and   column_name = 'Comments' ;
 
update pdm.edq_view_default_cols
  set sort_order = 10
where view_catalog_id = 112
and   column_name = 'Variable Method' ;
 
update pdm.edq_view_default_cols
  set sort_order = 9
where view_catalog_id = 112
and   column_name = 'Variable Name' ;
 
update pdm.edq_view_default_cols
  set sort_order = 8
where view_catalog_id = 112
and   column_name = 'Variable Type' ;
 
update pdm.edq_view_default_cols
  set sort_order = 7
where view_catalog_id = 112
and   column_name = 'Variable Id' ;
 
update pdm.edq_view_default_cols
  set sort_order = 6
where view_catalog_id = 112
and   column_name = 'Formula' ;
 
update pdm.edq_view_default_cols
  set sort_order = 5
where view_catalog_id = 112
and   column_name = 'Product' ;
 
insert into pdm.edq_view_default_cols 
       ( view_catalog_id, column_name, sort_order )
values ( 112, 'Calculation Category', 3) ;
 
insert into pdm.edq_view_default_cols 
       ( view_catalog_id, column_name, sort_order )
values ( 112, 'Balancing Group', 4) ;
 
-- -------------------------------------------------------------------------------------
-- New Code List View Definition
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 121, 'PDM_CODES', 'Code Table Lists', 'QUERY', 'EC', 0, 'Configuration' ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for PDM_CODES
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 121, 'Code Type', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 121, 'Code', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 121, 'Code Text', 3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 121, 'Is System Code?', 4 ) ;
 
-- -------------------------------------------------------------------------------------
-- New Equipment Master View Definition
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 122, 'PDM_EQUIPMENT_MASTER', 'Equipment Master', 'QUERY', 'EC', 0, 'Configuration' ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for PDM_EQUIPMENT_MASTER
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Field / Project', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Equipment Type', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Equipment Code', 3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Equipment Name', 4 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Effective Date', 5 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 122, 'Expiry Date', 6 ) ;
 
-- -------------------------------------------------------------------------------------
-- New Validation View Definition
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 123, 'PDM_EC_VALIDATIONS', 'EC Data Validations', 'QUERY', 'EC', 0, 'Cenovus' ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for PDM_EC_VALIDATIONS
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 123, 'Field / Project', 1 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 123, 'Severity Level', 2 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 123, 'Status', 3 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 123, 'Log Message', 4 ) ;
 
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 123, 'Production Date', 5 ) ;
 
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_EC_VALIDATIONS', 'Facility Id', 'HR' ) ;
 
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_EC_VALIDATIONS', 'Production Date', 'DT' ) ;
 
-- -------------------------------------------------------------------------------------
-- New Facility Summary View Definition
-- -------------------------------------------------------------------------------------
-- insert into pdm.edq_view_catalog
--        ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
-- values ( 124, 'PDM_FACILITY_SUMMARY', 'Facility Summary', 'QUERY', 'EC', 0, 'Views' ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for PDM_FACILITY_SUMMARY
-- -------------------------------------------------------------------------------------
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Field / Project',            1 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Production Date',            2 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Regulatory Code',            3 ) ;
-- Diluent Columns ---------------------------------------------------------------------
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Opening Inventory',  4 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Receipts',           5 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Dispositions',       6 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Injections',         7 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Shrinkage',          8 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Used to Blend',      9 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Closing Inventory', 10 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Diluent Balance',           11 ) ;
-- Gas Columns -------------------------------------------------------------------------
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Production',            12 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Receipts',              13 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Dispositions',          14 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Injections',            15 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Fuel',                  16 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Flare',                 17 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Vent',                  18 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Metering Difference',   19 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Gas Balance',               20 ) ;
-- Water Columns -----------------------------------------------------------------------
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Opening Inventory',   21 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Production',          22 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Receipts',            23 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Trucked In',          24 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Load Recoveries',     25 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Recycled',            26 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Dispositions',        27 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Trucked Out',         28 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Load Injections',     29 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Plant Use',           30 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Metering Difference', 31 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Closing Inventory',   32 ) ;
-- insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
--                                values ( 124, 'Water Balance',             33 ) ;
-- -- -------------------------------------------------------------------------------------
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Production', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Receipts', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Dispositions', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Injections', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Fuel', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Flare', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Vent', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Metering Difference', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Gas Balance',             'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Receipts', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Recycled', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Load Injections', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Load Recoveries', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Plant Use', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Production', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Metering Difference', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Trucked In', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Trucked Out', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Dispositions', 'SUM' ) ;
--  
-- insert into pdm.edq_view_agg_cols ( view_catalog_id, column_name, operation )
--                            values ( 124, 'Water Balance',      'SUM' ) ;
-- -- -------------------------------------------------------------------------------------
-- insert into pdm.edq_object_col_map
--        ( schema, object_name, column_name, map_type ) 
-- values ( 'EC', 'PDM_FACILITY_SUMMARY', 'Production Date', 'DT' ) ;
--  
-- insert into pdm.edq_object_col_map
--        ( schema, object_name, column_name, map_type ) 
-- values ( 'EC', 'PDM_FACILITY_SUMMARY', 'Facility Id', 'HR' ) ;
--  
-- -------------------------------------------------------------------------------------
-- New Revenue View Definitions
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 125, 'RR_FIN_ACCOUNT', 'Financial Account Master', 'QUERY', 'EC', 0, 'Revenue Views' ) ;
 
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 126, 'RR_COST_CENTRE', 'Financial Cost Centre Master', 'QUERY', 'EC', 0, 'Revenue Views' ) ;
 
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 127, 'RR_AFE', 'Financial AFE Master', 'QUERY', 'EC', 0, 'Revenue Views' ) ;
 
-- -------------------------------------------------------------------------------------
-- New Reserves / POIP View
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 128, 'PDM_WELL_POIP', 'Produceable Oil in Place', 'QUERY', 'EC', 0, 'Reserves Views' ) ;
 
-- -------------------------------------------------------------------------------------
-- Default Columns for PDM_WELL_POIP
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Field / Project',            1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Production Date',            2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Sub Surface Pad Group',      3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Location',                   4 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Produceable Oil in Place bbls', 5 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Produceable Oil in Place m3', 6 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Steamable Oil in Place bbls', 7 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 128, 'Steamable Oil in Place m3', 8 ) ;
-- -- -------------------------------------------------------------------------------------
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_WELL_POIP', 'Production Date', 'DT' ) ;
 
insert into pdm.edq_object_col_map
       ( schema, object_name, column_name, map_type ) 
values ( 'EC', 'PDM_WELL_POIP', 'Facility Id', 'HR' ) ;

-- -------------------------------------------------------------------------------------
-- New SOX View Definitions
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 190, 'SOX_ROLE_ACCESS', 'Role Access List', 'QUERY', 'EC', 0, 'SOX Views' ) ;
 
insert into pdm.edq_view_catalog
       ( id, view_name, friendly_name, output_style, schema, disabled, reporting_group )
values ( 191, 'SOX_USER_ROLE', 'Roles granted to Users', 'QUERY', 'EC', 0, 'SOX Views' ) ;
 
-- -------------------------------------------------------------------------------------
-- Default Columns for RR_FIN_ACCOUNT
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Account', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Name', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Subledger Reqd?', 3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Units Reqd?', 4 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Effective Date', 5 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 125, 'Expiry Date', 6 ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for RR_COST_CENTRE
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 126, 'Cost Centre', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 126, 'Name', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 126, 'Effective Date', 5 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 126, 'Expiry Date', 6 ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for RR_AFE
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 127, 'AFE', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 127, 'Name', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 127, 'Effective Date', 5 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 127, 'Expiry Date', 6 ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for SOX_ROLE_ACCESS
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 190, 'Role Name', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 190, 'Object Description', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 190, 'Object Type', 3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 190, 'Access Level', 4 ) ;
-- -------------------------------------------------------------------------------------
-- Default Columns for SOX_USER_ROLE
-- -------------------------------------------------------------------------------------
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 191, 'User Name', 1 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 191, 'User Id', 2 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 191, 'Role Id', 3 ) ;
insert into pdm.edq_view_default_cols ( view_catalog_id, column_name, sort_order )
                               values ( 191, 'Role Name', 4 ) ;

