-- Run this ONCE in Supabase Dashboard -> SQL Editor -> New query -> Run.
-- Public upload access is intentional for no-login wedding guests. Anyone with
-- the site URL can upload. Use an unguessable event URL, monitoring and moderation.
create table if not exists public.party_photos (
 id uuid primary key,
 event_id text not null,
 path text not null unique,
 created_at timestamptz not null default now()
);
alter table public.party_photos enable row level security;
drop policy if exists "Guests can view party photos" on public.party_photos;
drop policy if exists "Guests can add party photos" on public.party_photos;
create policy "Guests can view party photos" on public.party_photos for select to anon using (event_id='our-wedding');
create policy "Guests can add party photos" on public.party_photos for insert to anon
 with check (event_id='our-wedding' and path like 'our-wedding/%' and length(path)<150);
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
 values ('party-photos','party-photos',true,3145728,array['image/jpeg'])
 on conflict(id) do update set public=true,file_size_limit=3145728,allowed_mime_types=array['image/jpeg'];
drop policy if exists "Guests can see wedding photos" on storage.objects;
drop policy if exists "Guests can upload wedding photos" on storage.objects;
create policy "Guests can see wedding photos" on storage.objects for select to anon
 using (bucket_id='party-photos' and (storage.foldername(name))[1]='our-wedding');
create policy "Guests can upload wedding photos" on storage.objects for insert to anon
 with check (bucket_id='party-photos' and (storage.foldername(name))[1]='our-wedding'
 and lower(storage.extension(name))='jpg');
