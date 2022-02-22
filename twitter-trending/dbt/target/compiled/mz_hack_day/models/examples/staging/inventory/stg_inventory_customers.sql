/*

The purpose of this model is to create an inventory_customers staging model.

 */





WITH source AS (

    SELECT * FROM "materialize"."public"."inventory_customers"

),

renamed AS (

    SELECT

       id::numeric as id,
       first_name::string as first_name,
       last_name::string as last_name,
       email::string as email

    FROM source

)

SELECT * FROM renamed