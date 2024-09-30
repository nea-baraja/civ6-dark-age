
create table if not exists Unity_Sources (
    SourceName text primary key,
    SourceProperty text,
    SourceDescription text
    );

insert into Unity_Sources (SourceName) 
values 
    ('QIN_WATER_DISTRICT'),
    ('GOVERNMENT_BUILDING'),
    ('POLICY');

update Unity_Sources 
set SourceProperty = 'PROP_UNITY_SOURCE_'||SourceName,
    SourceDescription = 'LOC_UNITY_SOURCE_'||SourceName||'_DESCRIPTION';


