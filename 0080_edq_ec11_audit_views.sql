-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_PHD_REVISIONS - EC PHD Mapping Revisions
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
DROP VIEW EC.PDM_PHD_REVISIONS_JN ;

CREATE VIEW EC.PDM_PHD_REVISIONS_JN 

AS SELECT
   --  Master Information
       fcty.asset_team                                   AS "Asset Team",
       fcty.asset                                        AS "Asset",
       fcty.property                                     AS "Property",
       fcty.field_project                                AS "Field/Project",
       fcty.facility_id                                  AS "Facility Id",
       fcty.facility_name                                AS "Facility Name",
       fcty.aer_code                                     AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.mapping_no                                     AS "Mapping No",
       'WELL'                                            AS "Object Type",
       well.well_id                                      AS "Object Id",
       well.well_code                                    AS "Object Code",
       well.field_location                               AS "Object Name",
 --  PHD Data
       MAP(od.source_id, 'PHD_CL',      'PHD Christina Lake',
                         'PHD_FC',      'PHD Foster Creek',
                         'PHD_FC_INFO', 'PHD Christina Lake Informational',
                         'PHD_FC_INFO', 'PHD Foster Creek Informational',
                         od.source_id)                   AS "Source Id",
       od.data_class                                     AS "Class Name",
       od.attribute                                      AS "Attribute",
       od.tag_id                                         AS "PHD Tag Id",
       MAP(tt.description, null, 'Deleted Template', tt.description)
                                                         AS "Template Name",
       od.from_unit                                      AS "From Unit",
       od.to_unit                                        AS "To Unit",
       od.active                                         AS "Active?",
 --     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_phd_revision_data_jn od 
LEFT OUTER JOIN SRC_EC.trans_template tt 
    ON od.template_no = tt.template_no 
INNER JOIN INTEGRATIONS.FDC_WELL well
    ON  well_id        = od.object_id
    AND effective_date = (select max(effective_date)
                          from INTEGRATIONS.FDC_WELL
                          where well_id = od.object_id
                          and   source  = 'EC' )
INNER JOIN INTEGRATIONS.FDC_FACILITY FCTY
    ON  well.facility_id       =    FCTY.facility_id
    AND well.effective_date    >=   FCTY.effective_date
    AND well.effective_date    <    IFNULL(FCTY.expiry_date, add_days(well.effective_date, 1))
UNION ALL 
SELECT
 --  Master Information
       fcty.asset_team                                   AS "Asset Team",
       fcty.asset                                        AS "Asset",
       fcty.property                                     AS "Property",
       fcty.field_project                                AS "Field/Project",
       fcty.facility_id                                  AS "Facility Id",
       fcty.facility_name                                AS "Facility Name",
       fcty.aer_code                                     AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.mapping_no                                     AS "Mapping No",
       'TANK'                                            AS "Object Type",
       tank.tank_id                                      AS "Object Id",
       tank.tank_code                                    AS "Object Code",
       tank.tank_name                                    AS "Object Name",
   --  PHD Data
       MAP(od.source_id, 'PHD_CL',      'PHD Christina Lake',
                         'PHD_FC',      'PHD Foster Creek',
                         'PHD_FC_INFO', 'PHD Christina Lake Informational',
                         'PHD_FC_INFO', 'PHD Foster Creek Informational',
                         od.source_id)                   AS "Source Id",
       od.data_class                                     AS "Class Name",
       od.attribute                                      AS "Attribute",
       od.tag_id                                         AS "PHD Tag Id",
       MAP(tt.description, null, 'Deleted Template', tt.description) 
                                                         AS "Template Name",
       od.from_unit                                      AS "From Unit",
       od.to_unit                                        AS "To Unit",
       od.active                                         AS "Active?",
 --     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_phd_revision_data_jn od 
LEFT OUTER JOIN SRC_EC.trans_template tt 
    ON od.template_no = tt.template_no 
INNER JOIN INTEGRATIONS.FDC_TANK tank 
    ON od.object_id = tank.tank_id
    AND tank.effective_date = (select max(effective_date)
                               from INTEGRATIONS.FDC_TANK
                               where tank_id = od.object_id
                               and   source  = 'EC' )
INNER JOIN INTEGRATIONS.FDC_FACILITY FCTY
    ON  tank.facility_id       =    FCTY.facility_id
    AND tank.effective_date    >=   FCTY.effective_date
    AND tank.effective_date    <    IFNULL(FCTY.expiry_date, add_days(tank.effective_date, 1))
UNION ALL 
SELECT
   --  Master Information
       fcty.asset_team                                   AS "Asset Team",
       fcty.asset                                        AS "Asset",
       fcty.property                                     AS "Property",
       fcty.field_project                                AS "Field/Project",
       fcty.facility_id                                  AS "Facility Id",
       fcty.facility_name                                AS "Facility Name",
       fcty.aer_code                                     AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.mapping_no                                     AS "Mapping No",
       'STREAM'                                          AS "Object Type",
       strm.stream_id                                    AS "Object Id",
       strm.stream_code                                  AS "Object Code",
       strm.stream_name                                  AS "Object Name",
 --  PHD Data
       MAP(od.source_id, 'PHD_CL',      'PHD Christina Lake',
                         'PHD_FC',      'PHD Foster Creek',
                         'PHD_FC_INFO', 'PHD Christina Lake Informational',
                         'PHD_FC_INFO', 'PHD Foster Creek Informational',
                         od.source_id)                   AS "Source Id",
       od.data_class                                     AS "Class Name",
       od.attribute                                      AS "Attribute",
       od.tag_id                                         AS "PHD Tag Id",
       MAP(tt.description, null, 'Deleted Template', tt.description) AS "Template Name",
       od.from_unit                                      AS "From Unit",
       od.to_unit                                        AS "To Unit",
       od.active                                         AS "Active?",
 --     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_phd_revision_data_jn od 
LEFT OUTER JOIN SRC_EC.trans_template tt 
    ON od.template_no = tt.template_no 
INNER JOIN INTEGRATIONS.FDC_STREAM strm
    ON od.object_id = strm.stream_id
    AND strm.effective_date = (select max(effective_date)
                               from INTEGRATIONS.FDC_STREAM
                               where stream_id = od.object_id
                               and   source  = 'EC' )
INNER JOIN INTEGRATIONS.FDC_FACILITY FCTY
    ON  strm.facility_id       =    FCTY.facility_id
    AND strm.effective_date    >=   FCTY.effective_date
    AND strm.effective_date    <    IFNULL(FCTY.expiry_date, add_days(strm.effective_date, 1))
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_SUMMARY_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
DROP VIEW EC.PDM_SUMMARY_JN ;

CREATE VIEW EC.PDM_SUMMARY_JN
AS 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'TANK'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       MAP(oa.last_updated_date, null, 'INS', 'UPD')     AS "Journal Operation",
       MAP(oa.last_updated_date, null, oa.created_by, oa.last_updated_by) 
                                                         AS "Journal User Id",
       MAP(oa.last_updated_date, null, oa.created_date, oa.last_updated_date) 
                                                         AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), 
                             IFNULL(oa.last_updated_date, oa.created_date))), 1, 
                             o.last_updated_by, oa.last_updated_by) 
                                                         AS "Last Updated By",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), 
                             IFNULL(oa.last_updated_date, oa.created_date))), 1, 
                             o.last_updated_date, oa.last_updated_date) 
                                                         AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.tank o 
INNER JOIN SRC_EC.tank_version oa 
    ON o.object_id = oa.object_id 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'TANK'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       oa.last_updated_by                                AS "Last Updated By",
       oa.last_updated_date                              AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.tank                       o 
INNER JOIN SRC_EC.tank_version_jn      oa 
    ON  o.object_id  = oa.object_id 
    AND o.start_date = oa.daytime 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'TANK'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       IFNULL(oa.name, oa2.name)                         AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       IFNULL(oa.daytime, oa2.daytime)                   AS "Start Date",
       IFNULL(oa.end_date, oa2.end_date)                 AS "End Date",
       IFNULL(oa.text_2, oa2.text_2)                     AS "PA Interface",
       IFNULL(oa.record_status, oa2.record_status)       AS "Record Status",
       IFNULL(oa.created_by, oa2.created_by)             AS "Created By",
       IFNULL(oa.created_date, oa2.created_date)         AS "Created Date",
       IFNULL(oa.last_updated_by, oa2.last_updated_by)   AS "Last Updated By",
       IFNULL(oa.last_updated_date, oa2.last_updated_date) 
                                                         AS "Last Updated Date",
       IFNULL(oa.rev_text, oa2.rev_text)                 AS "Revision Text",
       IFNULL(oa.approval_state, oa2.approval_state)     AS "Approval State",
       IFNULL(oa.approval_by, oa2.approval_by)           AS "Approval By",
       IFNULL(oa.approval_date, oa2.approval_date)       AS "Approval Date" 
FROM SRC_EC.tank_jn o 
LEFT OUTER JOIN SRC_EC.tank_version_jn oa 
    ON o.object_id = oa.object_id 
    AND o.created_date = oa.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa.last_updated_date, current_date) 
LEFT OUTER JOIN SRC_EC.tank_version oa2 
    ON o.object_id = oa2.object_id 
    AND o.created_date = oa2.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa2.last_updated_date, current_date) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'WELL'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       MAP(oa.last_updated_date, null, 'INS', 'UPD')     AS "Journal Operation",
       MAP(oa.last_updated_date, null, oa.created_by, oa.last_updated_by)
                                                         AS "Journal User Id",
       MAP(oa.last_updated_date, null, oa.created_date, oa.last_updated_date)
                                                         AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), IFNULL(oa.last_updated_date, oa.created_date))), 1, o.last_updated_by, oa.last_updated_by)  
                                                         AS "Last Updated By",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), IFNULL(oa.last_updated_date, oa.created_date))), 1, o.last_updated_date, oa.last_updated_date)
                                                         AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.well o 
INNER JOIN SRC_EC.well_version oa 
    ON o.object_id = oa.object_id 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'WELL'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       oa.last_updated_by                                AS "Last Updated By",
       oa.last_updated_date                              AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.well o 
INNER JOIN SRC_EC.well_version_jn oa 
    ON o.object_id = oa.object_id 
    AND o.start_date = oa.daytime 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'WELL'                                            AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       IFNULL(oa.name, oa2.name)                         AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       IFNULL(oa.daytime, oa2.daytime)                   AS "Start Date",
       IFNULL(oa.end_date, oa2.end_date)                 AS "End Date",
       IFNULL(oa.text_2, oa2.text_2)                     AS "PA Interface",
       IFNULL(oa.record_status, oa2.record_status)       AS "Record Status",
       IFNULL(oa.created_by, oa2.created_by)             AS "Created By",
       IFNULL(oa.created_date, oa2.created_date)         AS "Created Date",
       IFNULL(oa.last_updated_by, oa2.last_updated_by)   AS "Last Updated By",
       IFNULL(oa.last_updated_date, oa2.last_updated_date)
                                                         AS "Last Updated Date",
       IFNULL(oa.rev_text, oa2.rev_text)                 AS "Revision Text",
       IFNULL(oa.approval_state, oa2.approval_state)     AS "Approval State",
       IFNULL(oa.approval_by, oa2.approval_by)           AS "Approval By",
       IFNULL(oa.approval_date, oa2.approval_date)       AS "Approval Date" 
FROM SRC_EC.well_jn o 
LEFT OUTER JOIN SRC_EC.well_version_jn oa 
    ON  o.object_id = oa.object_id 
    AND o.created_date = oa.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa.last_updated_date, current_date) 
LEFT OUTER JOIN SRC_EC.well_version oa2
    ON o.object_id = oa2.object_id 
    AND o.created_date = oa2.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa2.last_updated_date, current_date) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'STREAM'                                          AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       MAP(oa.last_updated_date, null, 'INS', 'UPD')     AS "Journal Operation",
       MAP(oa.last_updated_date, null, oa.created_by, oa.last_updated_by) 
                                                         AS "Journal User Id",
       MAP(oa.last_updated_date, null, oa.created_date, oa.last_updated_date)
                                                         AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), IFNULL(oa.last_updated_date, oa.created_date))), 1, o.last_updated_by, oa.last_updated_by) 
                                                         AS "Last Updated By",
       MAP(sign(days_between(IFNULL(o.last_updated_date, o.created_date), IFNULL(oa.last_updated_date, oa.created_date))), 1, o.last_updated_date, oa.last_updated_date)
                                                         AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.stream o 
INNER JOIN SRC_EC.strm_version oa
    ON o.object_id = oa.object_id 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'STREAM'                                          AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       oa.name                                           AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       oa.daytime                                        AS "Start Date",
       oa.end_date                                       AS "End Date",
       oa.text_2                                         AS "PA Interface",
       oa.record_status                                  AS "Record Status",
       oa.created_by                                     AS "Created By",
       oa.created_date                                   AS "Created Date",
       oa.last_updated_by                                AS "Last Updated By",
       oa.last_updated_date                              AS "Last Updated Date",
       oa.rev_text                                       AS "Revision Text",
       oa.approval_state                                 AS "Approval State",
       oa.approval_by                                    AS "Approval By",
       oa.approval_date                                  AS "Approval Date" 
FROM SRC_EC.stream o 
INNER JOIN SRC_EC.strm_version_jn oa
    ON o.object_id = oa.object_id 
    AND o.start_date = oa.daytime 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
UNION ALL 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       'STREAM'                                          AS "Object Type",
       o.object_id                                       AS "Object Id",
       o.object_code                                     AS "Object Code",
       IFNULL(oa.name, oa2.name)                         AS "Object Name",
       o.rev_no || '.' || oa.rev_no                      AS "Revision",
       oa.jn_operation                                   AS "Journal Operation",
       oa.jn_oracle_user                                 AS "Journal User Id",
       oa.jn_datetime                                    AS "Journal Date",
       IFNULL(oa.daytime, oa2.daytime)                   AS "Start Date",
       IFNULL(oa.end_date, oa2.end_date)                 AS "End Date",
       IFNULL(oa.text_2, oa2.text_2)                     AS "PA Interface",
       IFNULL(oa.record_status, oa2.record_status)       AS "Record Status",
       IFNULL(oa.created_by, oa2.created_by)             AS "Created By",
       IFNULL(oa.created_date, oa2.created_date)         AS "Created Date",
       IFNULL(oa.last_updated_by, oa2.last_updated_by)   AS "Last Updated By",
       IFNULL(oa.last_updated_date, oa2.last_updated_date)
                                                         AS "Last Updated Date",
       IFNULL(oa.rev_text, oa2.rev_text)                 AS "Revision Text",
       IFNULL(oa.approval_state, oa2.approval_state)     AS "Approval State",
       IFNULL(oa.approval_by, oa2.approval_by)           AS "Approval By",
       IFNULL(oa.approval_date, oa2.approval_date)       AS "Approval Date" 
FROM SRC_EC.stream_jn o 
LEFT OUTER JOIN SRC_EC.strm_version_jn oa
    ON o.object_id = oa.object_id 
    AND o.created_date = oa.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa.last_updated_date, current_date) 
LEFT OUTER JOIN SRC_EC.strm_version oa2
    ON o.object_id = oa2.object_id 
    AND o.created_date = oa2.created_date 
    AND IFNULL(o.last_updated_date, current_date) = IFNULL(oa2.last_updated_date, current_date) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_STRM_REVISIONS_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
DROP VIEW EC.PDM_STRM_REVISIONS_JN ;

CREATE VIEW EC.PDM_STRM_REVISIONS_JN
AS SELECT
     --  Master Information
       f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.object_id                                      AS "Object Id",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_code                                    AS "Stream Code",
       od.daytime                                        AS "Start Date",
       od.end_date                                       AS "End Date",
       od.name                                           AS "Stream Name",
       od.text_1                                         AS "PA Interface",
       od.text_2                                         AS "MARP ID",
       pc_1.code_text                                    AS "Project Phase",
       od.name                                           AS "SND Label",
       pc_2.code_text                                    AS "Stream Phase",
       pc_3.code_text                                    AS "Stream Category",
       pc_4.code_text                                    AS "Stream Type",
       pc_5.code_text                                    AS "Meter Method",
       pc_6.code_text                                    AS "Stream Meter Frequency",
       pc_7.code_text                                    AS "Alloc Period",
       pc_8.code_text                                    AS "Alloc Data Frequency",
       pc_9.code_text                                    AS "Alloc Fixed?",
       pc_10.code_text                                   AS "Gross Volume Method",
       pc_11.code_text                                   AS "Net Volume Method",
       pc_12.code_text                                   AS "BSW Volume Method",
       pc_13.code_text                                   AS "On Stream Method",
       pc_14.code_text                                   AS "Std Density Method",
       pc_15.code_text                                   AS "Water Volume Method",
       pc_16.code_text                                   AS "Water Mass Method",
       pc_17.code_text                                   AS "Component Set",
       pdt.object_code                                   AS "Product",
       od.comments                                       AS "Comments",
       sn_1.name                                         AS "From Node",
       sn_2.name                                         AS "To Node",
       sv_2.name                                         AS "Ref. Analysis Stream",
       sv_3.name                                         AS "Ref. Diluent Stream",
       sv_4.name                                         AS "Ref. Bitumen Stream",
       od.text_3                                         AS "Carry Forward",
 --     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_strm_revision_data_jn od 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  od.op_fcty_class_1_id =  f.facility_id 
    AND od.daytime            >= f.effective_date 
    AND od.daytime            <  IFNULL(f.expiry_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN EC.pdm_stream_nodes sn_1 
    ON od.from_node_id = sn_1.object_id 
    AND od.daytime >= sn_1.start_date 
    AND od.daytime < IFNULL(sn_1.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN EC.pdm_stream_nodes sn_2 
    ON od.to_node_id = sn_2.object_id 
    AND od.daytime >= sn_2.start_date 
    AND od.daytime < IFNULL(sn_2.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.strm_version sv_2 
    ON od.ref_analysis_stream_id = sv_2.object_id 
    AND od.daytime >= sv_2.daytime 
    AND od.daytime < IFNULL(sv_2.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.strm_version sv_3 
    ON od.ref_diluent_stream_id = sv_3.object_id 
    AND od.daytime >= sv_3.daytime 
    AND od.daytime < IFNULL(sv_3.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.strm_version sv_4 
    ON od.ref_bitumen_stream_id = sv_4.object_id 
    AND od.daytime >= sv_4.daytime 
    AND od.daytime < IFNULL(sv_4.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.product pdt 
    ON od.product_id = pdt.object_id 
    AND od.daytime >= pdt.start_date 
    AND od.daytime < IFNULL(pdt.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_1 
    ON pc_1.code_type = 'CEN_PROJECT_PHASE' 
    AND od.text_5 = pc_1.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_2 
    ON pc_2.code_type = 'STREAM_PHASE' 
    AND od.stream_phase = pc_2.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_3 
    ON pc_3.code_type = 'STREAM_CATEGORY' 
    AND od.stream_category = pc_3.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_4 
    ON pc_4.code_type = 'STREAM_TYPE' 
    AND od.stream_type = pc_4.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_5 
    ON pc_5.code_type = 'METER_METHOD' 
    AND od.strm_meter_method = pc_5.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_6 
    ON pc_6.code_type = 'METER_FREQ' 
    AND od.strm_meter_freq = pc_6.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_7 
    ON pc_7.code_type = 'ALLOC_PERIOD' 
    AND od.alloc_period = pc_7.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_8 
    ON pc_8.code_type = 'ALLOC_DATA_FREQ' 
    AND od.alloc_data_freq = pc_8.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_9 
    ON pc_9.code_type = 'YES_NO' 
    AND od.alloc_fixed = pc_9.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_10 
    ON pc_10.code_type = 'GRS_VOL_METHOD' 
    AND od.grs_vol_method = pc_10.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_11 
    ON pc_11.code_type = 'NET_VOL_METHOD' 
    AND od.net_vol_method = pc_11.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_12 
    ON pc_12.code_type = 'BSW_VOL_METHOD' 
    AND od.bsw_vol_method = pc_12.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_13 
    ON pc_13.code_type = 'STRM_ON_STREAM_METHOD' 
    AND od.on_stream_method = pc_13.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_14 
    ON pc_14.code_type = 'STD_DENSITY_METHOD' 
    AND od.std_dens_method = pc_14.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_15 
    ON pc_15.code_type = 'WATER_VOL_METHOD' 
    AND od.water_vol_method = pc_15.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_16 
    ON pc_16.code_type = 'WATER_MASS_METHOD' 
    AND od.water_mass_method = pc_16.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_17 
    ON pc_17.code_type = 'COMP_SET_CODE' 
    AND od.comp_set_code = pc_17.code 
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_VOLUME_CHANGES_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

DROP VIEW EC.PDM_VOLUME_CHANGES_JN ;

CREATE VIEW EC.PDM_VOLUME_CHANGES_JN 
AS 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Meter Volume'                                    AS field_id,
       od_jn.grs_vol                                     AS original_value,
       od.grs_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.grs_vol, 0) <> IFNULL(od_jn.grs_vol, 0) 
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Meter Volume'                                    AS field_id,
       od_jn.grs_vol                                     AS original_value,
       od.grs_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream_jn od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.grs_vol, 0) <> IFNULL(od_jn.grs_vol, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Totalizer'                                       AS field_id,
       od_jn.totalizer                                   AS original_value,
       od.totalizer                                      AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.totalizer, 0) <> IFNULL(od_jn.totalizer, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Totalizer'                                       AS field_id,
       od_jn.totalizer                                   AS original_value,
       od.totalizer                                      AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream_jn od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.totalizer, 0) <> IFNULL(od_jn.totalizer, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'BS_W'                                            AS field_id,
       od_jn.bs_w                                        AS original_value,
       od.bs_w                                           AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.bs_w, 0) <> IFNULL(od_jn.bs_w, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'BS_W'                                            AS field_id,
       od_jn.bs_w                                        AS original_value,
       od.bs_w                                           AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream_jn od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.bs_w, 0) <> IFNULL(od_jn.bs_w, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'DENSITY'                                         AS field_id,
       od_jn.density                                     AS original_value,
       od.density                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.density, 0) <> IFNULL(od_jn.density, 0)
UNION ALL 
SELECT 'STREAM'                                          AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'DENSITY'                                         AS field_id,
       od_jn.density                                     AS original_value,
       od.density                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.strm_day_stream_jn od 
INNER JOIN SRC_EC.strm_day_stream_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.density, 0) <> IFNULL(od_jn.density, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Dip Level'                                       AS field_id,
       od_jn.grs_dip_level                               AS original_value,
       od.grs_dip_level                                  AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.tank_measurement od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.grs_dip_level, 0) <> IFNULL(od_jn.grs_dip_level, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
      od.object_id                                       AS object_id,
      od_jn.jn_operation                                 AS jn_operation,
      od_jn.jn_oracle_user                               AS jn_oracle_user,
      od_jn.jn_datetime                                  AS jn_datetime,
      od.daytime                                         AS daytime,
      'Dip Level'                                        AS field_id,
      od_jn.grs_dip_level                                AS original_value,
      od.grs_dip_level                                   AS override_value,
      od.rev_no                                          AS rev_no,
      od.comments                                        AS comments,
      od.record_status                                   AS record_status,
      od.created_by                                      AS created_by,
      od.created_date                                    AS created_date,
      od.last_updated_by                                 AS last_updated_by,
      od.last_updated_date                               AS last_updated_date,
      od.rev_text                                        AS rev_text 
FROM SRC_EC.tank_measurement_jn od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.grs_dip_level, 0) <> IFNULL(od_jn.grs_dip_level, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Gross Volume'                                    AS field_id,
       od_jn.grs_vol                                     AS original_value,
       od.grs_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.tank_measurement od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
   ON od.object_id = od_jn.object_id 
   AND od.daytime = od_jn.daytime 
   AND od.rev_no = od_jn.rev_no + 1 
   AND IFNULL(od.grs_vol, 0) <> IFNULL(od_jn.grs_vol, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Gross Volume'                                    AS field_id,
       od_jn.grs_vol                                     AS original_value,
       od.grs_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.tank_measurement_jn od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.grs_vol, 0) <> IFNULL(od_jn.grs_vol, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Density'                                         AS field_id,
       od_jn.density                                     AS original_value,
       od.density                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.tank_measurement od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.density, 0) <> IFNULL(od_jn.density, 0)
UNION ALL 
SELECT 'TANK'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Density'                                         AS field_id,
       od_jn.grs_vol                                     AS original_value,
       od.grs_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.tank_measurement_jn od 
INNER JOIN SRC_EC.tank_measurement_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.density, 0) <> IFNULL(od_jn.density, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Run Hours'                                       AS field_id,
       od_jn.on_stream_hrs                               AS original_value,
       od.on_stream_hrs                                  AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.on_stream_hrs, 0) <> IFNULL(od_jn.on_stream_hrs, 0)
UNION ALL
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Run Hours'                                       AS field_id,
       od_jn.on_stream_hrs                               AS original_value,
       od.on_stream_hrs                                  AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.on_stream_hrs, 0) <> IFNULL(od_jn.on_stream_hrs, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Oil Volume'                             AS field_id,
       od_jn.avg_oil_rate                                AS original_value,
       od.avg_oil_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_oil_rate, 0) <> IFNULL(od_jn.avg_oil_rate, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Oil Volume'                             AS field_id,
       od_jn.avg_oil_rate                                AS original_value,
       od.avg_oil_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_oil_rate, 0) <> IFNULL(od_jn.avg_oil_rate, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Gas Volume'                             AS field_id,
       od_jn.avg_gas_rate                                AS original_value,
       od.avg_gas_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_gas_rate, 0) <> IFNULL(od_jn.avg_gas_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type <> 'WID'
UNION ALL 
SELECT
       'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Gas Volume'                             AS field_id,
       od_jn.avg_gas_rate                                AS original_value,
       od.avg_gas_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_gas_rate, 0) <> IFNULL(od_jn.avg_gas_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type <> 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Water Volume'                           AS field_id,
       od_jn.avg_water_rate                              AS original_value,
       od.avg_water_rate                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_water_rate, 0) <> IFNULL(od_jn.avg_water_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type <> 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Measured Water Volume'                           AS field_id,
       od_jn.avg_water_rate                              AS original_value,
       od.avg_water_rate                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_water_rate, 0) <> IFNULL(od_jn.avg_water_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type <> 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Liquid Volume'                                   AS field_id,
       od_jn.avg_liquid_rate_m3                          AS original_value,
       od.avg_liquid_rate_m3                             AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_liquid_rate_m3, 0) <> IFNULL(od_jn.avg_liquid_rate_m3, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Liquid Volume'                                   AS field_id,
       od_jn.avg_liquid_rate_m3                          AS original_value,
       od.avg_liquid_rate_m3                             AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_liquid_rate_m3, 0) <> IFNULL(od_jn.avg_liquid_rate_m3, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'BS_W'                                            AS field_id,
       od_jn.bs_w                                        AS original_value,
       od.bs_w                                           AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.bs_w, 0) <> IFNULL(od_jn.bs_w, 0)
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'BS_W'                                            AS field_id,
       od_jn.bs_w                                        AS original_value,
       od.bs_w                                           AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.bs_w, 0) <> IFNULL(od_jn.bs_w, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Inner Tubing Volume'                             AS field_id,
       od_jn.inj_vol                                     AS original_value,
       od.inj_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol, 0) <> IFNULL(od_jn.inj_vol, 0)
UNION ALL
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Inner Tubing Volume'                             AS field_id,
       od_jn.inj_vol                                     AS original_value,
       od.inj_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol, 0) <> IFNULL(od_jn.inj_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Outer Tubing Volume'                             AS field_id,
       od_jn.inj_vol_2                                   AS original_value,
       od.inj_vol_2                                      AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol_2, 0) <> IFNULL(od_jn.inj_vol_2, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Outer Tubing Volume'                             AS field_id,
       od_jn.inj_vol_2                                   AS original_value,
       od.inj_vol_2                                      AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol_2, 0) <> IFNULL(od_jn.inj_vol_2, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Butane Injection Volume'                         AS field_id,
       od_jn.ca_inj_c4sp_vol                             AS original_value,
       od.ca_inj_c4sp_vol                                AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id   = od_jn.object_id 
    AND od.daytime    = od_jn.daytime 
    AND od.inj_type   = od_jn.inj_type 
    AND od.inj_type   = 'SI' 
    AND od.rev_no     = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_c4sp_vol, 0) <> IFNULL(od_jn.ca_inj_c4sp_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Butane Injection Volume'                         AS field_id,
       od_jn.ca_inj_c4sp_vol                             AS original_value,
       od.ca_inj_c4sp_vol                                AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_c4sp_vol, 0) <> IFNULL(od_jn.ca_inj_c4sp_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Gas Injection Volume'                            AS field_id,
       od_jn.ca_inj_gas_vol                              AS original_value,
       od.ca_inj_gas_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_gas_vol, 0) <> IFNULL(od_jn.ca_inj_gas_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Gas Injection Volume'                            AS field_id,
       od_jn.ca_inj_gas_vol                              AS original_value,
       od.ca_inj_gas_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_gas_vol, 0) <> IFNULL(od_jn.ca_inj_gas_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Air Injection Volume'                            AS field_id,
       od_jn.ca_inj_air_vol                              AS original_value,
       od.ca_inj_air_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_air_vol, 0) <> IFNULL(od_jn.ca_inj_air_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Air Injection Volume'                            AS field_id,
       od_jn.ca_inj_air_vol                              AS original_value,
       od.ca_inj_air_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_air_vol, 0) <> IFNULL(od_jn.ca_inj_air_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'CO2 Injection Volume'                            AS field_id,
       od_jn.ca_inj_co2_vol                              AS original_value,
       od.ca_inj_co2_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_co2_vol, 0) <> IFNULL(od_jn.ca_inj_co2_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'CO2 Injection Volume'                            AS field_id,
       od_jn.ca_inj_co2_vol                              AS original_value,
       od.ca_inj_co2_vol                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_co2_vol, 0) <> IFNULL(od_jn.ca_inj_co2_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Diluent Injection Volume'                        AS field_id,
       od_jn.ca_inj_cond_vol                             AS original_value,
       od.ca_inj_cond_vol                                AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_cond_vol, 0) <> IFNULL(od_jn.ca_inj_cond_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Diluent Injection Volume'                        AS field_id,
       od_jn.ca_inj_cond_vol                             AS original_value,
       od.ca_inj_cond_vol                                AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'SI' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_inj_cond_vol, 0) <> IFNULL(od_jn.ca_inj_cond_vol, 0)
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Produced Water Injection'                        AS field_id,
       od_jn.inj_vol                                     AS original_value,
       od.inj_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'WD' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol, 0) <> IFNULL(od_jn.inj_vol, 0) 
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Produced Water Injection'                        AS field_id,
       od_jn.inj_vol                                     AS original_value,
       od.inj_vol                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'WD' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.inj_vol, 0) <> IFNULL(od_jn.inj_vol, 0) 
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Blowdown Water Injection'                        AS field_id,
       od_jn.ca_blowdown_inj_vol                         AS original_value,
       od.ca_blowdown_inj_vol                            AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'WD' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_blowdown_inj_vol, 0) <> IFNULL(od_jn.ca_blowdown_inj_vol, 0) 
UNION ALL 
SELECT 'IWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Blowdown Water Injection'                        AS field_id,
       od_jn.ca_blowdown_inj_vol                         AS original_value,
       od.ca_blowdown_inj_vol                            AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.iwel_day_status_jn od 
INNER JOIN SRC_EC.iwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.inj_type = od_jn.inj_type 
    AND od.inj_type = 'WD' 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.ca_blowdown_inj_vol, 0) <> IFNULL(od_jn.ca_blowdown_inj_vol, 0) 
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Water Source Volume'                             AS field_id,
       od_jn.avg_water_rate                              AS original_value,
       od.avg_water_rate                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_water_rate, 0) <> IFNULL(od_jn.avg_water_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Water Source Volume'                             AS field_id,
       od_jn.avg_water_rate                              AS original_value,
       od.avg_water_rate                                 AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_water_rate, 0) <> IFNULL(od_jn.avg_water_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Water Aux Volume'                                AS field_id,
       od_jn.value_4                                     AS original_value,
       od.value_4                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.value_4, 0) <> IFNULL(od_jn.value_4, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'Water Aux Volume'                                AS field_id,
       od_jn.value_4                                     AS original_value,
       od.value_4                                        AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.value_4, 0) <> IFNULL(od_jn.value_4, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'WS Gas Volume'                                   AS field_id,
       od_jn.avg_gas_rate                                AS original_value,
       od.avg_gas_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_gas_rate, 0) <> IFNULL(od_jn.avg_gas_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
UNION ALL 
SELECT 'PWEL'                                            AS object_type,
       od.object_id                                      AS object_id,
       od_jn.jn_operation                                AS jn_operation,
       od_jn.jn_oracle_user                              AS jn_oracle_user,
       od_jn.jn_datetime                                 AS jn_datetime,
       od.daytime                                        AS daytime,
       'WS Gas Volume'                                   AS field_id,
       od_jn.avg_gas_rate                                AS original_value,
       od.avg_gas_rate                                   AS override_value,
       od.rev_no                                         AS rev_no,
       od.comments                                       AS comments,
       od.record_status                                  AS record_status,
       od.created_by                                     AS created_by,
       od.created_date                                   AS created_date,
       od.last_updated_by                                AS last_updated_by,
       od.last_updated_date                              AS last_updated_date,
       od.rev_text                                       AS rev_text 
FROM SRC_EC.pwel_day_status_jn od 
INNER JOIN SRC_EC.pwel_day_status_jn od_jn 
    ON od.object_id = od_jn.object_id 
    AND od.daytime = od_jn.daytime 
    AND od.rev_no = od_jn.rev_no + 1 
    AND IFNULL(od.avg_gas_rate, 0) <> IFNULL(od_jn.avg_gas_rate, 0) 
INNER JOIN SRC_EC.well_version oa ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
    AND oa.well_type = 'WID'
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_VOLUMETRIC_CHANGES_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

DROP VIEW EC.PDM_VOLUMETRIC_CHANGES_JN ;

CREATE VIEW EC.PDM_VOLUMETRIC_CHANGES_JN
AS 
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_type                                    AS "Object Type",
       o.object_code                                     AS "Object Code",
       o.object_id                                       AS "Object Id",
       od.daytime                                        AS "Production Date",
       to_char(od.daytime, 'Mon') || ' ' || YEAR(od.daytime)
                                                         AS "Production Month",
       oa.name                                           AS "Object Name",
       oa.text_1                                         AS "PA Interface",
       od.field_id                                       AS "Field Id",
       od.original_value                                 AS "PHD Volume",
       to_double(od.override_value)                      AS "Override Volume",
       od.comments                                       AS "Comments",
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_volume_changes_jn od 
INNER JOIN SRC_EC.stream o 
    ON  od.object_id = o.object_id 
INNER JOIN SRC_EC.strm_version oa 
    ON  od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
WHERE od.object_type = 'STREAM'
UNION ALL
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_type                                    AS "Object Type",
       o.object_code                                     AS "Object Code",
       o.object_id                                       AS "Object Id",
       od.daytime                                        AS "Production Date",
       to_char(od.daytime, 'Mon') || ' ' || YEAR(od.daytime) 
                                                         AS "Production Month",
       oa.name                                           AS "Object Name",
       oa.text_1                                         AS "PA Interface",
       od.field_id                                       AS "Field Id",
       od.original_value                                 AS "PHD Volume",
       to_double(od.override_value)                      AS "Override Volume",
       od.comments                                       AS "Comments",
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_volume_changes_jn od 
INNER JOIN SRC_EC.tank o 
    ON od.object_id = o.object_id 
INNER JOIN SRC_EC.tank_version oa 
    ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
WHERE od.object_type = 'TANK'
UNION ALL
SELECT f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_type                                    AS "Object Type",
       o.object_code                                     AS "Object Code",
       o.object_id                                       AS "Object Id",
       od.daytime                                        AS "Production Date",
       to_char(od.daytime, 'Mon') || ' ' || YEAR(od.daytime) 
                                                         AS "Production Month",
       oa.name                                           AS "Object Name",
       oa.text_1                                         AS "PA Interface",
       od.field_id                                       AS "Field Id",
       od.original_value                                 AS "PHD Volume",
       to_double(od.override_value)                      AS "Override Volume",
       od.comments                                       AS "Comments",
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_volume_changes_jn od 
INNER JOIN SRC_EC.well o 
    ON od.object_id = o.object_id 
INNER JOIN SRC_EC.well_version oa 
    ON od.object_id = oa.object_id 
    AND od.daytime >= oa.daytime 
    AND od.daytime < IFNULL(oa.end_date, add_days(od.daytime, 1)) 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  oa.op_fcty_class_1_id =  f.facility_id 
    AND oa.daytime            >= f.effective_date 
    AND oa.daytime            <  IFNULL(f.expiry_date, add_days(oa.daytime, 1)) 
WHERE od.object_type in ('PWEL', 'IWEL')
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_TANK_REVISIONS_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
DROP VIEW EC.PDM_TANK_REVISIONS_JN ;

CREATE VIEW EC.PDM_TANK_REVISIONS_JN 
AS 
SELECT 
--     Master Information
       f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.object_id                                      AS "Object Id",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_code                                    AS "Tank Code",
       od.daytime                                        AS "Start Date",
       od.end_date                                       AS "End Date",
       od.name                                           AS "Tank Name",
       od.text_1                                         AS "PA Interface",
       pc_1.code_text                                    AS "Project Phase",
       od.sort_order                                     AS "Sort Order",
       od.bf_usage                                       AS "Use in BF",
       pc_2.code_text                                    AS "Tank Type",
       pc_3.code_text                                    AS "Tank Gross Volume Method",
       pc_4.code_text                                    AS "Tank Net Volume Method",
       pc_5.code_text                                    AS "Tank Diluent Method",
       pc_6.code_text                                    AS "Tank BSW Volume Method",
       pc_7.code_text                                    AS "Tank Diluent Density Method",
       pc_8.code_text                                    AS "Tank Bitumen Density Method",
       pc_9.code_text                                    AS "VCF Method",
       pc_10.code_text                                   AS "Free Water Volume Method",
       pc_11.code_text                                   AS "Water Volume Method",
       pc_12.code_text                                   AS "Standard Density Method",
       pc_13.code_text                                   AS "Strapping Method",
       pc_14.code_text                                   AS "Strap Level UOM",
       pc_15.code_text                                   AS "Strap Value Type",
       od.val_per_dip_fact                               AS "Value Per Strap Unit",
       pc_16.code_text                                   AS "Tank Tap UOM",
       od.min_vol                                        AS "Min Tank Quantity m3",
       od.max_vol                                        AS "Max Tank Quantity m3",
       sv_1.name                                         AS "Export Stream",
       sv_2.name                                         AS "Analysis Stream",
       w.object_code                                     AS "Dedicated Tank for Well",
--     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_tank_revision_data_jn od 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  od.op_fcty_class_1_id =  f.facility_id 
    AND od.daytime            >= f.effective_date 
    AND od.daytime            <  IFNULL(f.expiry_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_1 
    ON od.text_4              =  pc_1.code 
    AND pc_1.code_type        =  'CEN_PROJECT_PHASE' 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_2 
    ON  pc_2.code_type        =  'TANK_TYPE' 
    AND od.tank_type          =  pc_2.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_3 
    ON  pc_3.code_type        =  'TANK_GRS_VOL_METHOD' 
    AND od.grs_vol_method     =  pc_3.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_4 
    ON  pc_4.code_type        =  'TANK_NET_VOL_METHOD' 
    AND od.net_vol_method     =  pc_4.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_5 
    ON  pc_5.code_type        =  'TANK_DILUENT_METHOD' 
    AND od.diluent_method     =  pc_5.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_6 
    ON  pc_6.code_type        =  'BSW_VOL_METHOD' 
    AND od.bs_w_vol_method    =  pc_6.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_7 
    ON  pc_7.code_type        = 'TANK_DILUENT_DENS_METHOD' 
    AND od.diluent_dens_method = pc_7.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_8 
    ON  pc_8.code_type        = 'TANK_BITUMEN_DENS_METHOD' 
    AND od.bitumen_dens_method = pc_8.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_9 
    ON  pc_9.code_type        =  'TANK_VCF_METHOD' 
    AND od.vcf_method         =  pc_9.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_10 
    ON  pc_10.code_type       =  'TANK_FREE_WATER_VOL_METHOD' 
    AND od.free_wat_vol_met   =  pc_10.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_11 
    ON  pc_11.code_type       =  'TANK_WATER_VOL_METHOD' 
    AND od.water_vol_method   =  pc_11.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_12 
    ON  pc_12.code_type       =  'TANK_STD_DENSITY_METHOD' 
    AND od.density_method     =  pc_12.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_13 
    ON  pc_13.code_type       =  'STRAPPING_METHOD' 
    AND od.strapping_method   =  pc_13.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_14 
    ON  pc_14.code_type       =  'TANK_STRAP_UOM' 
    AND od.strap_level_uom    =  pc_14.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_15 
    ON  pc_15.code_type       =  'STRAP_VALUE_TYPE' 
    AND od.strap_value_type   =  pc_15.code 
LEFT OUTER JOIN SRC_EC.prosty_codes pc_16 
    ON  pc_16.code_type       =  'TANK_STRAP_UOM' 
    AND od.text_2             =  pc_16.code 
LEFT OUTER JOIN SRC_EC.strm_version sv_1 
    ON  od.export_stream_id   =  sv_1.object_id 
    AND od.daytime            >= sv_1.daytime 
    AND od.daytime            <  IFNULL(sv_1.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.strm_version sv_2 
    ON  od.analysis_stream_id = sv_2.object_id 
    AND od.daytime >= sv_2.daytime 
    AND od.daytime < IFNULL(sv_2.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.well w 
    ON  od.tank_well = w.object_id 
WITH READ ONLY ;

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- PDM_WELL_REVISIONS_JN
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
DROP VIEW EC.PDM_WELL_REVISIONS_JN ;

CREATE VIEW EC.PDM_WELL_REVISIONS_JN 
AS
SELECT 
--     Master Information
       f.asset_team                                      AS "Asset Team",
       f.asset                                           AS "Asset",
       f.property                                        AS "Property",
       f.field_project                                   AS "Field/Project",
       f.facility_id                                     AS "Facility Id",
       f.facility_name                                   AS "Facility Name",
       f.aer_code                                        AS "Regulatory Code",
       od.object_id                                      AS "Object Id",
       od.rev_no                                         AS "Revision",
       od.jn_operation                                   AS "Journal Operation",
       od.jn_oracle_user                                 AS "Journal User Id",
       od.jn_datetime                                    AS "Journal Date",
       od.object_code                                    AS "Well Code",
       od.daytime                                        AS "Start Date",
       od.end_date                                       AS "End Date",
       od.name                                           AS "Well Name",
       od.text_2                                         AS "PA Interface",
       MAP(od.text_16, 'CL_PHASE_AB',   'Christina Lake Phase A/B', 
                       'CL_PHASE_C',    'Christina Lake Phase C',
                       'CL_PHASE_D',    'Christina Lake Phase D',
                       'CL_PHASE_E',    'Christina Lake Phase E',
                       'CL_SUSTAINING', 'Christina Lake Sustaining',
                       'FC_PHASE_A_E',  'Foster Creek Phase A-E',
                       'FC_PHASE_F_H',  'Foster Creek Phase F-H',
                       'FC_SUSTAINING', 'Foster Creek Sustaining',
                       od.text_16)                       AS "Project Phase",
       od.official_name                                  AS "Official Name",
       od.text_1                                         AS "Cost Center",
       MAP(od.text_13, 'AI',       'Air Injector', 
                       'BWS',      'Brackish Water Source',
                       'DISPOSAL', 'Disposal',
                       'EXP',      'Experimental',
                       'FWS',      'Fresh Water Source',
                       'GI',       'Gas Injector',
                       'OBS',      'Observation Well',
                       'OP',       'Oil Producer',
                       'SAGD_I',   'SAGD Injector',
                       'SAGD_P',   'SAGD Producer',
                       'SI',       'Steam Injector',
                       'WEDGE',    'Wedge Well',
                       od.text_13)                       AS "SAGD Well Type",
       MAP(od.well_type, 'AB',   'Abandoned', 
                         'AI',   'Air Injector',
                         'CI',   'CO2 Injector',
                         'CP',   'Condensate Producer',
                         'GI',   'Gas Injector',
                         'GP',   'Gas Producer (Gas/Water/Cond)',
                         'GP2',  'Gas Producer (Gas/Oil/Wat)',
                         'GPI',  'Gas Producer and Gas Injector',
                         'OB',   'Observation',
                         'OP',   'Oil Producer',
                         'OPGI', 'Oil Producer and Gas Injector',
                         'OPSI', 'Oil Producer and Steam Injector',
                         'SI',   'Steam Injector',
                         'SWG',  'Sim. Water and Gas Inj',
                         'WA',   'Waste',
                         'WG',   'Water and Gas Injector',
                         'WI',   'Water Injector',
                         'WID',  'Water Injection for Disposal',
                         'WP',   'Water Producer (Water and Gas)',
                         'WS',   'Water Source',
                         'WSI',  'Water and Steam Injector',
                         od.well_type)                   AS "Well Type",
       MAP(od.text_15, 'DRILLED',    'Drilled', 
                       'LT_CLOSED',  'Long Term Closed',
                       'NORMAL',     'Open Normal',
                       'NOT_IN_USE', 'Not in Use',
                       'REDUCED',    'Choked Back',
                       'SHUT_IN',    'Shut in',
                       'SUSPENDED',  'Suspended',
                       'WORK_OVER',  'Work over',
                       od.text_15)                       AS "Well Status",
       MAP(od.prod_method, 'SAGD_I', 'SAGD Injector', 
                           'SAGD_P', 'SAGD Producer',
                           'SAGD_W', 'SAGD Wedge',
                           'D',      'Water Disposal Well',
                           'PU',     'Pumped',
                           'ST',     'Steam Injector',
                           od.prod_method)               AS "Production Method",
       MAP(od.well_meter_freq, 'DAY',  'Day', 
                               'MTH',  'Month',
                               'NA',   'Not Applicable',
                               'YR',   'Year',
                               od.well_meter_freq)       AS "Meter Frequency",
       MAP(od.instrumentation_type, '1', 'Instr Type 1', 
                                    '2', 'Instr Type 2',
                                    '3', 'Instr Type 3',
                                    od.instrumentation_type) AS "Instrumentation Type",
       MAP(od.bf_profile, 'PROD', 'Production Well Profile', 
                          'INJ', 'Injection Well Profile',
                          'PRODINJ', 'Prod and Inj Well Profile',
                          od.bf_profile)                 AS "Business Function Profile",
       MAP(od.on_strm_method, 
           'MEASURED',                        'Measured', 
           'USER_EXIT_24_IF_GT0',             'User Exit - If Theo Vol > 0 Then 24 Otherwise 0',
           'USER_EXIT_MIN_0_MAX_24',          'User Exit - Sets to 0 if negative, 24 if > 24',
           'USER_EXIT_TANK_CLOSING_TIME',     'User Exit - Determined base on Tank Closing Time',
           od.on_strm_method)                            AS "On Stream Method",
       MAP(od.calc_method, 
           'WELL_EST_DETAIL',                 'Welltest * on time', 
           'USER_EXIT_CA_WELL_EST_DETAIL',    'Welltest * on time (CA)', 
           'TANK_WELL',                       'SWB Tank delta + Trucked',
           'USER_EXIT_CA_TANK_WELL',          'SWB Tank delta + Trucked (CA)',
           'LIQUID_MEASURED',                 'Meas liquid rate',
           'USER_EXIT_CA_LIQUID_MEASURED',    'Meas liquid rate (CA)',
           od.calc_method)                               AS "Theor Oil Production Method",
       MAP(od.calc_gas_method, 
           'OIL_GOR',                         'Oil * GOR', 
           'USER_EXIT_CA_OIL_GOR',            'Oil * GOR (CA)', 
           'WELL_EST_DETAIL',                 'Welltest * on time',
           'USER_EXIT_CA_WELL_EST_DETAIL',    'Welltest * on time (CA)',
           'MEASURED',                        'Meas incl artificial lift',
           'USER_EXIT_CA_MEASURED',           'Meas incl artificial lift (CA)',
           'WATER_GWR',                       'Water * GWR',
           'USER_EXIT_CA_WATER_GWR',          'Water * GWR (CA)',
           od.calc_gas_method)                           AS "Theor Gas Production Method",
       MAP(od.calc_water_method, 
           'WELL_EST_DETAIL',                 'Welltest * on time', 
           'USER_EXIT_CA_WELL_EST_DETAIL',    'Welltest * on time (CA)', 
           'TANK_WELL',                       'SWB Tank delta + Trucked',
           'USER_EXIT_CA_TANK_WELL',          'SWB Tank delta + Trucked (CA)',
           'OIL_WOR',                         'Oil * WOR',
           'USER_EXIT_CA_OIL_WOR',            'Oil * WOR (CA)',
           'USER_EXIT',                       'User Exit',
           'LIQUID_MEASURED',                 'Meas Liquid rate',
           'USER_EXIT_CA_LIQUID_MEASURED',    'Meas Liquid rate (CA)',
           od.calc_water_method)                         AS "Theor Water Production Method",
       MAP(od.calc_water_inj_method, 
           'USER_EXIT',                       'User Exit', 
           'USER_EXIT_CA_TOT_WAT_INJ',        'Theor Injected Water (CA)',
           od.calc_water_inj_method)                     AS "Theor Water Inj Method",
       MAP(od.calc_steam_inj_method, 
           'USER_EXIT',                       'User Exit', 
           'MEASURED',                        'Measured or entered',
           'USER_EXIT_CA_MEASURED',           'Measured or entered (CA)',
           od.calc_steam_inj_method)                     AS "Theor Steam Inj Method",
       od.alloc_flag                                     AS "Include in Allocation?",
       MAP(od.bsw_vol_method, 
           'CURVE',                           'Oil Curve', 
           'CURVE_LIQUID',                    'Liquid Curve',
           'MEASURED',                        'Measured',
           'SAMPLE_ANALYSIS',                 'Well Sample Analysis',
           'USER_EXIT',                       'User Exit',
           'WELL_EST_DETAIL',                 'Last Accepted Well Test',
           'WELL_REFERENCE',                  'Well Reference Value',
           'ZERO',                            'Zero',
           od.bsw_vol_method)                            AS "BSW Volume Method",
       MAP(od.gor_method, 
           'CURVE',                           'Oil Curve', 
           'CURVE_LIQUID',                    'Liquid Curve',
           'USER_EXIT',                       'User Exit',
           'WELL_EST_DETAIL',                 'Last Accepted Well Test',
           'WELL_REFERENCE',                  'Well Reference',
           od.gor_method)                                AS "GOR Method",
       MAP(od.wor_method, 
           'CURVE',                           'Oil Curve', 
           'CURVE_LIQUID',                    'Liquid Curve',
           'USER_EXIT',                       'User Exit',
           'WELL_REFERENCE',                  'Well Reference',
           'ZERO',                            'Zero',
           od.wor_method)                                AS "WOR Method",
       MAP(od.text_3, 
           'THERMAL',                         'Thermal', 
           'NON-THERMAL',                     'Non-Thermal',
           od.text_3)                                    AS "Water Purpose",
       'FCCL'                                            AS "Commercial Entity",
       MAP(od.text_4, 
           'SALINE',                          'Saline', 
           'NON-SALINE',                      'Non-Saline',
           od.text_4)                                    AS "Salinity",
       od.text_5                                         AS "OFM Location",
       wh.name                                           AS "Well Pair",
       od.text_6                                         AS "Well License",
       od.text_7                                         AS "Horizontal Well?",
       od.text_8                                         AS "Can Co Inj Butane?",
       od.text_9                                         AS "Can Co Inj Gas?",
       od.text_10                                        AS "Can Co Inj Air?",
       od.text_11                                        AS "Can Co Inj CO2?",
       od.text_12                                        AS "Can Co Inj Diluent?",
       od.comments                                       AS "Comments",
       od.IsProducer                                     AS "Is Producing?",
       od.IsSteamInjector                                AS "Is Steam Injector?",
       whup.name                                         AS "Well Pad",
--     ** Audit Trails
       od.record_status                                  AS "Record Status",
       od.created_by                                     AS "Created By",
       od.created_date                                   AS "Created Date",
       od.last_updated_by                                AS "Last Updated By",
       od.last_updated_date                              AS "Last Updated Date",
       od.rev_text                                       AS "Revision Text" 
FROM EC.pdm_well_revision_data_jn od 
INNER JOIN INTEGRATIONS.fdc_facility f 
    ON  od.op_fcty_class_1_id =  f.facility_id 
    AND od.daytime            >= f.effective_date 
    AND od.daytime            <  IFNULL(f.expiry_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.well_hookup_version whup 
    ON od.op_well_hookup_id = whup.object_id 
    AND od.daytime >= whup.daytime 
    AND od.daytime < IFNULL(whup.end_date, add_days(od.daytime, 1)) 
LEFT OUTER JOIN SRC_EC.well_hole_version wh 
    ON od.well_hole_id = wh.object_id 
    AND od.daytime >= wh.daytime 
    AND od.daytime < IFNULL(wh.end_date, add_days(od.daytime, 1)) 
WITH READ ONLY ;
   
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
grant select on EC.PDM_PHD_REVISIONS_JN       to PDM_READ ; 
grant select on EC.PDM_SUMMARY_JN             to PDM_READ ;
grant select on EC.PDM_STRM_REVISIONS_JN      to PDM_READ ;
grant select on EC.PDM_TANK_REVISIONS_JN      to PDM_READ ;
grant select on EC.PDM_WELL_REVISIONS_JN      to PDM_READ ;
grant select on EC.PDM_VOLUME_CHANGES_JN      to PDM_READ ;
grant select on EC.PDM_VOLUMETRIC_CHANGES_JN  to PDM_READ ;
