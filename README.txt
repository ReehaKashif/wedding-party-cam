WEDDING PARTY CAM — CONFIGURED FOR YOUR SUPABASE PROJECT

1. Go to https://supabase.com/dashboard and open project jwqtymufuwxneeudsacd.
2. Select SQL Editor -> New query. Copy and run the contents of supabase.sql.
   This creates public.party_photos, a public party-photos storage bucket,
   and anonymous read/upload policies.
3. Open your GitHub wedding-party-cam repository. Upload/replace index.html
   in the repository ROOT (not the ZIP or containing folder). Commit changes.
4. In GitHub Settings -> Pages confirm main branch / (root) is published.
5. On your iPhone open your exact GitHub Pages project URL in Safari.
6. Tap Open Camera, grant permission, then tap Take & Share Photo.
7. Scroll to Live Wedding Gallery. Photos appear within about 3 seconds.

The Supabase project URL and public publishable key are already in index.html.
Never put a Supabase secret or service_role key into the public website.

IMPORTANT: The no-login upload bucket can be abused by people with the link.
There is no real moderation, CAPTCHA, or server-side rate limiting in this
starter. Consider those before sending the QR code to 300 people.

This is free-tier compatible, NOT unlimited free photo storage/bandwidth.
Supabase and GitHub have quotas. The gallery shows the latest 300 images.
