-- Popular directions to ~ 300ms execution
-- 3863 Киев
-- 4037 Львов
-- 15 gillbus_mdc_test_ru

-- psql -d busfor -qAt -f 11-interesting-indexes-case.sql > analyze.json
-- https://tatiyants.com/pev
-- https://explain.depesz.com/

-- popular from
-- EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT  "directions".* FROM "directions"
-- WHERE "directions"."domain_id" = 1
--   AND "directions"."from_id" IN (
--     SELECT "cities"."id" FROM "cities"
--     INNER JOIN "cities_service_configs"
--       ON "cities"."id" = "cities_service_configs"."city_id"
--     WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
--     AND "cities"."hide" = false
--   )
--   AND "directions"."to_id" IN (
--     SELECT "cities"."id" FROM "cities"
--     INNER JOIN "cities_service_configs"
--       ON "cities"."id" = "cities_service_configs"."city_id"
--       WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
--       AND "cities"."hide" = false
--     )
--   AND ("directions"."from_id" = 3863)
--   AND "directions"."to_id" != 4037
-- ORDER BY "directions"."popularity" DESC LIMIT 5;

-- popular to
-- EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT  "directions".* FROM "directions"
-- WHERE "directions"."domain_id" = 1
--   AND "directions"."from_id" IN (
--     SELECT "cities"."id" FROM "cities"
--     INNER JOIN "cities_service_configs"
--       ON "cities"."id" = "cities_service_configs"."city_id"
--     WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
--     AND "cities"."hide" = false
--   )
--   AND "directions"."to_id" IN (
--     SELECT "cities"."id" FROM "cities"
--     INNER JOIN "cities_service_configs"
--       ON "cities"."id" = "cities_service_configs"."city_id"
--       WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
--       AND "cities"."hide" = false
--     )
--   AND "directions"."to_id" = 4037
--   AND ("directions"."from_id" != 3863)
-- ORDER BY "directions"."popularity" DESC LIMIT 5;

EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT  "directions".* FROM "directions"
WHERE "directions"."domain_id" = 1
  AND "directions"."from_id" IN (
    SELECT "cities"."id" FROM "cities"
    INNER JOIN "cities_service_configs"
      ON "cities"."id" = "cities_service_configs"."city_id"
    WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
    AND "cities"."hide" = false
  )
  AND "directions"."to_id" IN (
    SELECT "cities"."id" FROM "cities"
    INNER JOIN "cities_service_configs"
      ON "cities"."id" = "cities_service_configs"."city_id"
      WHERE "cities_service_configs"."service_config_id" = 15 -- gillbus_ru
      AND "cities"."hide" = false
    )
  AND "directions"."to_id" = 4037
  AND ("directions"."from_id" != 3863)
ORDER BY "directions"."popularity" DESC LIMIT 5;
