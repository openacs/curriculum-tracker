--
-- packages/curriculum-tracker/sql/curriculum-tracker-create.sql
--
-- @author Nick Carroll (nick.c@rroll.net)
-- @creation-date 2006-03-31
-- @cvs-id $Id$
--


drop table ct_uos_ga_map;

drop function ct_ga__name (integer);

drop function ct_ga__del (integer);

drop function ct_ga__new (
	integer,
	varchar,
	integer,
	varchar,
	integer,
	timestamptz,
	integer,
	varchar,
integer);

drop table ct_ga;

drop table ct_degree_uos_map;

drop function ct_uos__name (integer);

drop function ct_uos__del (integer);

drop function ct_uos__new (
	integer,
	varchar,
	varchar,
	varchar,
	varchar,
	varchar,
	varchar,
	varchar,
	varchar,
	varchar,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop table ct_uos;

drop function ct_degree_stream__name (integer);

drop function ct_degree__del (integer);

drop function ct_degree__new (
	integer,
	integer,
	varchar,
	varchar,
	varchar,
	integer,
	timestamptz,
	integer,
	varchar,
	integer
);

drop table ct_degree;

DELETE FROM acs_objects WHERE object_type='ct_ga';
DELETE FROM acs_objects WHERE object_type='ct_uos';
DELETE FROM acs_objects WHERE object_type='ct_degree';

select acs_object_type__drop_type ('ct_ga', 'f');
select acs_object_type__drop_type ('ct_uos', 'f');
select acs_object_type__drop_type ('ct_degree', 'f');
