set optimizer to off;
drop table  if exists pg_stat_test;
create table pg_stat_test(a int);

select
    schemaname, relname, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch, n_tup_ins, n_tup_upd,
    n_tup_del, n_tup_hot_upd, n_live_tup, n_dead_tup
from pg_stat_all_tables where relname = 'pg_stat_test';
select
    schemaname, relname, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch, n_tup_ins, n_tup_upd,
    n_tup_del, n_tup_hot_upd, n_live_tup, n_dead_tup
from pg_stat_user_tables where relname = 'pg_stat_test';
select
    schemaname, relname, indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
from pg_stat_all_indexes where relname = 'pg_stat_test';
select
    schemaname, relname, indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
from pg_stat_user_indexes where relname = 'pg_stat_test';

insert into pg_stat_test select * from generate_series(1, 100);

create index pg_stat_user_table_index on pg_stat_test(a);

select count(*) from pg_stat_test;

delete from pg_stat_test where a < 10;

update pg_stat_test set a = 1000 where a > 90;

set enable_seqscan to off;

select pg_sleep(1);

select * from pg_stat_test where a = 1;

reset enable_seqscan;

select
    schemaname, relname, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch, n_tup_ins, n_tup_upd,
    n_tup_del, n_tup_hot_upd, n_live_tup, n_dead_tup
from pg_stat_all_tables where relname = 'pg_stat_test';
select
    schemaname, relname, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch, n_tup_ins, n_tup_upd,
    n_tup_del, n_tup_hot_upd, n_live_tup, n_dead_tup
from pg_stat_user_tables where relname = 'pg_stat_test';
select
    schemaname, relname, indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
from pg_stat_all_indexes where relname = 'pg_stat_test';
select
    schemaname, relname, indexrelname, idx_scan, idx_tup_read, idx_tup_fetch
from pg_stat_user_indexes where relname = 'pg_stat_test';

reset optimizer;
