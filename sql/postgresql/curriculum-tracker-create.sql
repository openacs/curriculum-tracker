--
-- packages/curriculum-tracker/sql/curriculum-tracker-create.sql
--
-- @author Nick Carroll (nick.c@rroll.net)
-- @creation-date 2006-03-31
-- @cvs-id $Id$
--
--

--
-- Degree
--
create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''ct_degree'',                    	-- object_type
    ''#curriculum-tracker.degree#'',    -- pretty_name
    ''#curriculum-tracker.degrees#'',   -- pretty_plural
    ''acs_object'',                	-- supertype
    ''ct_degree'', 	                -- table_name
    ''degree_id'',	                -- id_column
    null,              		        -- package_name
    ''f'',                         	-- abstract_p
    null,                          	-- type_extension_table
    ''ct_degree_stream__name''         	-- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();
drop function inline_0 ();


create table ct_degree (
    degree_id    	integer 
                   	constraint ct_degree_degree_id_fk
                   	references acs_objects(object_id) 
                   	constraint ct_degree_degree_id_pk
                   	primary key,
    owner_id       	integer
                   	constraint ct_degree_owner_id_fk
                   	references users(user_id)
                   	constraint ct_degree_owner_id_nn
                   	not null,
    faculty_name   	varchar (512),
    department_name 	varchar (512),
    stream_name		varchar (512),
    package_id     	integer
                   	constraint ct_degree_package_id_fk
                   	references apm_packages(package_id)
                   	constraint ct_degree_package_id_nn
                   	not null
);


select define_function_args('ct_degree__new','degree_id,owner_id,faculty_name,department_name,stream_name,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function ct_degree__new (integer,integer,varchar,varchar,varchar,integer,timestamptz,integer,varchar,integer)
returns integer as '
declare
    p_degree_id                  alias for $1;        -- default null
    p_owner_id                   alias for $2;
    p_faculty_name               alias for $3;
    p_department_name            alias for $4;
    p_stream_name                alias for $5;
    p_package_id		 alias for $6;
    p_creation_date              alias for $7;        -- default now()
    p_creation_user              alias for $8;        -- default null
    p_creation_ip                alias for $9;        -- default null
    p_context_id                 alias for $10;        -- default null

    v_degree_id                ct_degree.degree_id%TYPE;
begin

    v_degree_id := acs_object__new (
        p_degree_id,
        ''ct_degree'',
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    insert into ct_degree (
        degree_id,
        owner_id,
        faculty_name,
        department_name,
        stream_name,
        package_id
    ) values (
        v_degree_id,
        p_owner_id,
        p_faculty_name,
	p_department_name,
	p_stream_name,
        p_package_id
    );

    PERFORM acs_permission__grant_permission(
          v_degree_id,
          p_creation_user,
          ''read''
    );

    PERFORM acs_permission__grant_permission(
          v_degree_id,
          p_creation_user,
          ''write''
    );

    return v_degree_id;

end;' language 'plpgsql';


select define_function_args('ct_degree__del','degree_id');

create function ct_degree__del (integer)
returns integer as '
declare
    p_degree_id                alias for $1;
    v_rec                      record;
begin
    -- Delete all UoS associated with degree.
    for v_rec in
        select uos_id from ct_degree_uos_map where degree_id = p_degree_id
    loop
        PERFORM ct_uos__del (v_rec.uos_id);
    end loop;

    delete from acs_permissions
           where object_id = p_degree_id;

    delete from ct_degree
           where degree_id = p_degree_id;

    raise NOTICE ''Deleting degree...'';
    PERFORM acs_object__delete(p_degree_id);

    return 0;

end;' language 'plpgsql';


select define_function_args('ct_degree_stream__name','degree_id');

create function ct_degree_stream__name (integer)
returns varchar as '
declare
    p_degree_id      alias for $1;
    v_stream_name    ct_degree.stream_name%TYPE;
begin
    select stream_name into v_stream_name
        from ct_degree
        where degree_id = p_degree_id;

    return v_stream_name;
end;
' language 'plpgsql';


--
-- UoS
--
create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''ct_uos'',                    	-- object_type
    ''#curriculum-tracker.unit_of_study#'',    -- pretty_name
    ''#curriculum-tracker.units_of_study#'',   -- pretty_plural
    ''acs_object'',                	-- supertype
    ''ct_uos'', 	                -- table_name
    ''uos_id'',  	                -- id_column
    null,              		        -- package_name
    ''f'',                         	-- abstract_p
    null,                          	-- type_extension_table
    ''ct_uos__name''             	-- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();
drop function inline_0 ();


create table ct_uos (
    uos_id      	integer 
                   	constraint ct_uos_uos_id_fk
                   	references acs_objects(object_id) 
                   	constraint ct_uos_uos_id_pk
                   	primary key,
    name		varchar (512),
    code		varchar (512),
    year		varchar (512),
    session             varchar (512),
    requirement         varchar (512),
    lecturer		varchar (512),
    objectives	  	text,
    outcomes		text,
    syllabus		text,
    completed_p		boolean,
    package_id     	integer
                   	constraint ct_uos_package_id_fk
                   	references apm_packages(package_id)
                   	constraint ct_uos_package_id_nn
                   	not null
);


select define_function_args('ct_uos__new','uos_id,name,code,year,session,requirement,lecturer,objectives,outcomes,syllabus,completed_p,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function ct_uos__new (integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,integer,timestamptz,integer,varchar,integer)
returns integer as '
declare
    p_uos_id                     alias for $1;        -- default null
    p_name                       alias for $2;
    p_code                       alias for $3;
    p_year                       alias for $4;
    p_session                    alias for $5;
    p_requirement		 alias for $6;
    p_lecturer			 alias for $7;
    p_objectives	   	 alias for $8;
    p_outcomes			 alias for $9;
    p_syllabus			 alias for $10;
    p_package_id		 alias for $11;
    p_creation_date              alias for $12;        -- default now()
    p_creation_user              alias for $13;        -- default null
    p_creation_ip                alias for $14;        -- default null
    p_context_id                 alias for $15;        -- default null

    v_uos_id                	 ct_uos.uos_id%TYPE;
    v_completed_p	    	 ct_uos.completed_p%TYPE;
begin

    v_uos_id := acs_object__new (
        p_uos_id,
        ''ct_uos'',
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    -- Set completed_p to 0 by default.
    v_completed_p := 0;

    insert into ct_uos (
        uos_id,
	name,
	code,
	year,
	session,
	requirement,
	lecturer,
	objectives,
	outcomes,
	syllabus,
	completed_p,
        package_id
    ) values (
        v_uos_id,
        p_name,
        p_code,
        p_year,
	p_session,
	p_requirement,
	p_lecturer,
	p_objectives,
	p_outcomes,
	p_syllabus,
	v_completed_p,
        p_package_id
    );

    PERFORM acs_permission__grant_permission(
          v_uos_id,
          p_creation_user,
          ''read''
    );

    PERFORM acs_permission__grant_permission(
          v_uos_id,
          p_creation_user,
          ''write''
    );

    return v_uos_id;

end;' language 'plpgsql';


select define_function_args('ct_uos__del','uos_id');

create function ct_uos__del (integer)
returns integer as '
declare
    p_uos_id                alias for $1;
    v_rec                   record;
begin
    -- Delete all GA associated with UoS.
    for v_rec in
        select ga_id from ct_uos_ga_map where uos_id = p_uos_id
    loop
        PERFORM ct_ga__del (v_rec.ga_id);
    end loop;

    -- Delete degree to uos mapping.
    delete from ct_degree_uos_map where uos_id = p_uos_id;

    delete from acs_permissions
           where object_id = p_uos_id;

    delete from ct_uos
           where uos_id = p_uos_id;

    raise NOTICE ''Deleting UoS...'';
    PERFORM acs_object__delete(p_uos_id);

    return 0;

end;' language 'plpgsql';


select define_function_args('ct_uos__name','uos_id');

create function ct_uos__name (integer)
returns varchar as '
declare
    p_uos_id      alias for $1;
    v_name    ct_uos.name%TYPE;
begin
    select name into v_name
        from ct_uos
        where uos_id = p_uos_id;

    return v_name;
end;
' language 'plpgsql';


create table ct_degree_uos_map (
    degree_id		integer,
    uos_id		integer
);

--
-- Graduate Attributes
--
create function inline_0 ()
returns integer as '
begin
    PERFORM acs_object_type__create_type (
    ''ct_ga'',                    	-- object_type
    ''#curriculum-tracker.graduate_attribute#'',    -- pretty_name
    ''#curriculum-tracker.graduate_attributes#'',   -- pretty_plural
    ''acs_object'',                	-- supertype
    ''ct_ga'',   	                -- table_name
    ''ga_id'',  	                -- id_column
    null,              		        -- package_name
    ''f'',                         	-- abstract_p
    null,                          	-- type_extension_table
    ''ct_ga__name''             	-- name_method
    );

    return 0;
end;' language 'plpgsql';

select inline_0 ();
drop function inline_0 ();


create table ct_ga (
    ga_id      	        integer 
                   	constraint ct_ga_ga_id_fk
                   	references acs_objects(object_id) 
                   	constraint ct_ga_ga_id_pk
                   	primary key,
    name		varchar (512),
    level		integer,
    description		text,
    package_id     	integer
                   	constraint ct_ga_package_id_fk
                   	references apm_packages(package_id)
                   	constraint ct_ga_package_id_nn
                   	not null
);


select define_function_args('ct_ga__new','ga_id,name,level,description,package_id,creation_date;now,creation_user,creation_ip,context_id');

create function ct_ga__new (integer,varchar,integer,varchar,integer,timestamptz,integer,varchar,integer)
returns integer as '
declare
    p_ga_id                      alias for $1;        -- default null
    p_name                       alias for $2;
    p_level                      alias for $3;
    p_description                alias for $4;
    p_package_id		 alias for $5;
    p_creation_date              alias for $6;        -- default now()
    p_creation_user              alias for $7;        -- default null
    p_creation_ip                alias for $8;        -- default null
    p_context_id                 alias for $9;        -- default null

    v_ga_id                ct_ga.ga_id%TYPE;
begin

    v_ga_id := acs_object__new (
        p_ga_id,
        ''ct_ga'',
        p_creation_date,
        p_creation_user,
        p_creation_ip,
        p_context_id
    );

    insert into ct_ga (
        ga_id,
	name,
	level,
	description,
        package_id
    ) values (
        v_ga_id,
        p_name,
        p_level,
        p_description,
        p_package_id
    );

    PERFORM acs_permission__grant_permission(
          v_ga_id,
          p_creation_user,
          ''read''
    );

    PERFORM acs_permission__grant_permission(
          v_ga_id,
          p_creation_user,
          ''write''
    );

    return v_ga_id;

end;' language 'plpgsql';


select define_function_args('ct_ga__del','ga_id');

create function ct_ga__del (integer)
returns integer as '
declare
    p_ga_id                alias for $1;
begin
    -- Delete uos to ga mapping.
    delete from ct_uos_ga_map where ga_id = p_ga_id;

    delete from acs_permissions
           where object_id = p_ga_id;

    delete from ct_ga
           where ga_id = p_ga_id;

    raise NOTICE ''Deleting Graduate Attribute...'';
    PERFORM acs_object__delete(p_ga_id);

    return 0;

end;' language 'plpgsql';


select define_function_args('ct_ga__name','ga_id');

create function ct_ga__name (integer)
returns varchar as '
declare
    p_ga_id      alias for $1;
    v_name       ct_ga.name%TYPE;
begin
    select name into v_name
        from ct_ga
        where ga_id = p_ga_id;

    return v_name;
end;
' language 'plpgsql';


--
-- Map Graduate Attribute to UoS.
--
create table ct_uos_ga_map (
    uos_id		integer,
    ga_id		integer
);
