WITH source_data AS (
    SELECT
        id,
        username,
        email,
        created_at
    FROM {{ source('source_db', 'users') }}
)

SELECT
    id,
    username,
    email,
    created_at,
    CONCAT(username, '_name') AS name
FROM source_data
