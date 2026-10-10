-- Run in Supabase SQL Editor AFTER your existing photo setup.
-- Public guest uploads: only share the event URL with trusted guests.
create table if not exists public.party_videos (
 id uuid primary key,
 event_id text not null,
 path text not null unique,
 created_at timestamptz not null default now()
);
alter table public.party_videos enable row level security;
drop policy if exists "Guests can view party videos" on public.party_videos;
drop policy if exists "Guests can add party videos" on public.party_videos;
create policy "Guests can view party videos" on public.party_videos for select to anon using (event_id='our-wedding');
create policy "Guests can add party videos" on public.party_videos for insert to anon with check (event_id='our-wedding' and path like 'our-wedding/%' and length(path)<150);
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('party-videos','party-videos',true,20971520,array['video/mp4','video/webm'])
on conflict(id) do update set public=true,file_size_limit=20971520,allowed_mime_types=array['video/mp4','video/webm'];
drop policy if exists "Guests can see wedding videos" on storage.objects;
drop policy if exists "Guests can upload wedding videos" on storage.objects;
create policy "Guests can see wedding videos" on storage.objects for select to anon
using (bucket_id='party-videos' and (storage.foldername(name))[1]='our-wedding');
create policy "Guests can upload wedding videos" on storage.objects for insert to anon
with check (bucket_id='party-videos' and (storage.foldername(name))[1]='our-wedding' and lower(storage.extension(name)) in ('mp4','webm'));
