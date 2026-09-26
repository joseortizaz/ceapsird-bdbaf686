create or replace view public.program_modules_catalog as
select m.id, m.programa_id, m.modulo_id, m.titulo,
       null::text as descripcion,
       m.orden, m.duracion_minutos, m.es_en_vivo, m.fecha_sesion, m.docente_id,
       m.created_at, m.updated_at
from public.program_modules m
where exists (select 1 from public.programs p
  where p.id = m.programa_id and p.estado = any (array['publicado','en_curso','finalizado']));
alter view public.program_modules_catalog set (security_invoker = off);
revoke insert, update, delete, truncate, references, trigger on public.program_modules_catalog from anon, authenticated;
grant select on public.program_modules_catalog to anon, authenticated;