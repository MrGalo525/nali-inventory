# NALI Inventory Web App

Free architecture:
- Frontend: GitHub Pages
- Database + login: Supabase
- Browser app: HTML/CSS/JavaScript
- Reports: CSV export for Excel

## Files
- index.html: complete web application
- supabase.sql: database tables + security policies

## Setup
1. Create a free Supabase project.
2. Open SQL Editor and run supabase.sql.
3. In Supabase Project Settings/API, copy the Project URL and publishable/anon key.
4. In index.html replace:
   PASTE_YOUR_SUPABASE_URL_HERE
   PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE
5. Create a public GitHub repository named nali-inventory.
6. Upload index.html and supabase.sql.
7. GitHub: Settings > Pages > Build and deployment > Source > Deploy from branch > main > / (root) > Save.
8. Open the generated GitHub Pages URL.

## Important security note
Only put the Supabase publishable/anon key in index.html. NEVER put a Supabase service-role/secret key in browser code. The SQL enables Row Level Security so users can only access rows belonging to their own authenticated account.

## How to use
Create products first:
- BOT500 = 500ml Empty Bottle
- BOT1500 = 1.5L Empty Bottle
- W350 = 350ml Nali Water
- W500 = 500ml Nali Water
- W1500 = 1.5L Nali Water
- W5000 = 5L Nali Water
Then record every movement as a transaction. Never change stock totals manually.

Example:
10,000 bottles made -> Manufactured 10,000
2,000 bottles sent to filling -> Adjustment Out 2,000 (for empty bottle stock)
2,000 filled water produced -> Filled 2,000 (for the finished-water SKU)
500 sold -> Sold 500

For better production traceability, use Reference for batch numbers and invoice numbers.
