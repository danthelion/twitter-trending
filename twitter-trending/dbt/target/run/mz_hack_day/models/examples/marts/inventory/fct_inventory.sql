create materialized view "materialize"."public"."fct_inventory"
  as (
    


select *
from "materialize"."public"."stg_inventory_customers"
  );