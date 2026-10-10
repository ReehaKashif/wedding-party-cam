WEDDING PARTY CAM - STARTER
1. Create a free project at https://supabase.com/.
2. In Supabase SQL Editor run supabase.sql. Review the public upload permissions and moderation risks.
3. Find Project URL and public anon/publishable key under Project Settings -> API.
4. Edit index.html: replace YOUR_SUPABASE_URL and YOUR_SUPABASE_ANON_KEY. Never put a service_role or secret key in this page.
5. Upload index.html to a free HTTPS static host (e.g. Cloudflare Pages or Netlify).
6. Open the public HTTPS URL on a phone. Test camera capture and gallery before sharing.
7. Generate a QR code for the deployed URL and print it.

Photos are JPEG-compressed before upload to save free storage. Gallery polls every 3 seconds and shows the newest 200 photos. This is near-live, not instantaneous. Guest count isn't capped in code, but 300 concurrent guests can exceed free-tier request/bandwidth/storage quotas. Free tiers are not unlimited. Public uploads risk spam and inappropriate photos; use moderation and rate limits before a large event. Images can be viewed by anyone with the link.
