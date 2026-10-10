-- Run in the Supabase SQL editor. This demo permits public guest uploads/read.
-- For a public event, add rate limits, abuse controls and moderation before sharing widely.
create table if not exists public.party_photos (
 id uuid primary key,
 event_id text not null,
 path text not null unique,
 created_at timestamptz not null default now()
);
alter table public.party_photos enable row level security;
create policy "Guests can view party photos" on public.party_photos for select to anon using (event_id = 'our-wedding');
create policy "Guests can add party photos" on public.party_photos for insert to anon with check (event_id = 'our-wedding' and path like 'our-wedding/%' and length(path)<150);
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types)
values ('party-photos','party-photos',true,3145728,array['image/jpeg'])
on conflict(id) do update set public=true,file_size_limit=3145728,allowed_mime_types=array['image/jpeg'];
create policy "Guests can see wedding photos" on storage.objects for select to anon using (bucket_id='party-photos');
create policy "Guests can upload wedding photos" on storage.objects for insert to anon with check (bucket_id='party-photos' and (storage.foldername(name))[1]='our-wedding' and lower(storage.extension(name))='jpg');
