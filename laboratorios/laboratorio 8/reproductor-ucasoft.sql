
select pglogical.replicate_ddl_command('
CREATE TABLE public.cancion(
    nombre varchar(100) not null,
    artista varchar(100) not null,
    URL varchar(100) not null,
    CONSTRAINT pk_cancion PRIMARY KEY (nombre,artista)
);
');

select pglogical.replicate_ddl_command('
CREATE TABLE public.playlist(
    nombre_cancion varchar(100) not null,
    artista_cancion varchar(100) not null,
    nombre_superpachanga varchar(100) not null,
    orden smallint check (orden>0),
    CONSTRAINT pk_playlist PRIMARY KEY (nombre_cancion,artista_cancion,nombre_superpachanga)
);
');

select pglogical.replicate_ddl_command('
    ALTER TABLE public.playlist ADD CONSTRAINT fk_playlist_cancion FOREIGN KEY (nombre_cancion,artista_cancion)
    REFERENCES public.cancion(nombre,artista) ON DELETE RESTRICT ON UPDATE CASCADE;
');

select pglogical.replicate_ddl_command('
    ALTER TABLE public.playlist ADD CONSTRAINT fk_playlist_superpachanga FOREIGN KEY (nombre_superpachanga)
    REFERENCES public.superpachanga(nombre) ON DELETE RESTRICT ON UPDATE CASCADE;
');

insert into superpachanga values ('Ebri badi gou tu de discotek','Japi dansing jalogüin',2020);

insert into cancion values ('Swan Song','Dua Lipa','https://www.youtube.com/watch?v=dQw4w9WgXcQ');

insert into playlist values ('Swan Song','Dua Lipa','Ebri badi gou tu de discotek',1);
