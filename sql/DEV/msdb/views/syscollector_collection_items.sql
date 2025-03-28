USE [msdb]
GO

CREATE   VIEW [dbo].[syscollector_collection_items]
AS
    SELECT
        i.collection_set_id,
        i.collection_item_id,
        i.collector_type_uid,
        CASE
            WHEN i.name_id IS NULL THEN i.name
            ELSE FORMATMESSAGE(i.name_id)
        END AS name,
        i.frequency,
        i.parameters
    FROM
        [dbo].[syscollector_collection_items_internal] i
GO

GRANT SELECT ON [syscollector_collection_items] TO [dc_operator]
GRANT SELECT ON [syscollector_collection_items] TO [dc_proxy]
GO
