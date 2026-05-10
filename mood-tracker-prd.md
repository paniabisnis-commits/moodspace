# Mood Space Product Requirement Document

## Document Purpose
Dokumen ini merinci UI/UX Mood Space berdasarkan struktur aplikasi yang sudah ditetapkan dan tidak mengubah arsitektur navigasi.

## Fixed Navigation Architecture
Bottom Navigation:
1. Beranda
2. Kalender
3. Analisis
4. Statistik
5. Pengaturan

Additional Screen:
- Detail Mood

## 1. Refined UX Flow

### Primary Flow
1. User membuka `Beranda`
2. User memilih mood cepat dari shortcut atau menekan CTA `Catat Mood`
3. User masuk ke `Detail Mood`
4. User memilih mood, menambah notes opsional, dan activity tags
5. User menekan `Simpan Mood`
6. App menampilkan saved state yang hangat dan singkat
7. Data langsung tercermin di `Kalender` dan `Statistik`

### Kalender Flow
1. User membuka `Kalender`
2. User melihat tampilan bulanan dengan indikator mood harian
3. User memilih tanggal
4. Panel detail di bawah kalender menampilkan mood history tanggal tersebut
5. User dapat merubah entri mood pada tanggal yang dipilih

### Analisis Flow
1. User membuka `Analisis`
2. User melihat distribusi emosi
3. User melihat pola hubungan antara aktivitas
4. User melihat tes kepribadian
5. User memahami beberapa kategori tes dan melakukan tes
6. User melihat hasil skor tes yang telah dikerjakan
7. User menyimpan hasil skor tes

### Statistik Flow
1. User membuka `Statistik`
2. User melihat tren mingguan atau bulanan
3. User melihat mood paling sering muncul
4. User melihat dampak aktivitas terhadap mood
5. User membaca summary konsistensi check-in

### UX Principles for Flow
- Maksimalkan check-in dalam kurang dari 15 detik.
- Tampilkan hanya satu keputusan utama per langkah.
- Gunakan feedback yang lembut setelah input tersimpan.
- Hindari bahasa yang terasa menghakimi, klinis, atau terlalu gamified.

## 2. Screen-by-Screen UI Specification

## 2.0 Onboarding Flow

### Screen Goal
Membangun koneksi emosional awal dan memberikan pengalaman onboarding yang personal sebelum pengguna mulai menggunakan aplikasi.

### Flow
1. User membuka aplikasi pertama kali
2. User memasukkan nama panggilan
3. User membaca komitmen self-care singkat
4. User melanjutkan ke Beranda

### UI Elements
- Greeting illustration/icon
- Name input field
- Supportive onboarding text
- Continue button
- Commitment/self-care message

### UX Notes
- Onboarding harus terasa ringan dan tidak terlalu panjang.
- Input nama digunakan untuk personalisasi pengalaman pengguna.
- Bahasa yang digunakan harus hangat dan suportif.

### Component Hierarchy
- `NameInputScreen`
- `CommitmentScreen`
- `PrimaryButton`
- `SectionAccentCard`

## 2.1 Beranda

### Screen Goal
Membantu user melakukan check-in mood secepat mungkin sambil memberi rasa tenang dan dukungan emosional.

### Content Blocks
- Greeting header
- Quick mood selector
- Influencing factors
- Mood & Energy Summary
- Mood Log Button
- Mood Insights & Reflections
- Mood Streak
- Mood Reminder

### Suggested Layout
Top to bottom:
1. Safe area header
2. Greeting + user name
3. Mood selector card
4. Chips factor
5. Card summary
6. Main CTA button
7. Card insight

### UI Elements
- Greeting text: `Halo, Nama`
- Subtext: `Bagaimana perasaanmu hari ini?`
- Mood selector:
  - opsi 5 emoji besar
- Quick tags:
  - `Senang`
  - `Tenang`
  - `Netral`
  - `Sedih`
  - `Marah`
- CTA:
  - `Catat Mood`

### UX Notes
- Mood input harus tampil di halaman pertama.
- CTA utama harus mudah dijangkau ibu jari.
- Jika user sudah log hari ini, akan tampil history di Calender, Analisis, Statistik.

### Component Hierarchy
- `HomeScreen`
- `HomeHeader`
- `GreetingBlock`
- `MoodQuickSelectCard`
- `QuickTagChips`
- `SupportCard`
- `PrimaryActionButton`
- `BottomNav`

## 2.2 Kalender

### Screen Goal
Menyediakan tampilan riwayat mood yang mudah dipindai dan mudah dipahami secara visual.

### Content Blocks
- Month header
- Monthly calendar
- Selected date detail
- Mood history list

### Suggested Layout
1. Top app bar dengan bulan aktif
2. Month navigation controls
3. Calendar grid
4. Selected date summary card
5. History entries list untuk tanggal tersebut

### UI Elements
- Header title: `Kalender Mood`
- Month switcher:
  - left chevron
  - current month label
  - right chevron
- Calendar cells:
  - date number
  - mood indicator berupa emoji mini atau soft color dot
- Selected date detail:
  - tanggal
  - mood label
  - notes preview
  - selected activities

### Interaction Rules
- Tap tanggal langsung meng-highlight cell.
- Hari tanpa entri mood tetap terlihat netral.
- Jika satu hari memiliki beberapa entri di masa depan, tampilkan indikator count kecil.

### UX Notes
- Jangan padati sel kalender.
- Indikator mood harus cukup kecil tetapi tetap terbaca.

### Component Hierarchy
- `CalendarScreen`
- `CalendarHeader`
- `MonthSwitcher`
- `MoodCalendarGrid`
- `CalendarDayCell`
- `SelectedDateMoodCard`
- `MoodHistoryList`
- `BottomNav`

## 2.3 Analisis

### Screen Goal
Memberikan insight emosional yang terasa personal, sederhana, dan suportif.

### Content Blocks
- Emotional breakdown
- Patterns found (`Hubungan`)
- Personality analysis (`Kepribadian`)
- Simple reflective insights

### Suggested Layout
1. Header title
2. Date range filter chip
3. Emotional breakdown cards
4. Relationship insights card
5. Personality trends card
6. Short supportive interpretation

### UI Elements
- Emotional breakdown:
  - label: `Senang`, `Tenang`, `Netral`, `Sedih`, `Marah`
- `Pola ditemukan` card:
  - contoh insight: `Mood kamu cenderung lebih stabil saat interaksi sosial meningkat.`
- `Analisis Kepribadian` card:
  - contoh insight: `Lihat Kepribadian.`

### Chart Guidance
- Maksimal 4-5 kategori per visual.
- Gunakan label langsung di chart atau di legend ringkas.
- Hindari visual analitik yang terlalu teknis.

### UX Notes
- Analisis harus terasa seperti insight, bukan diagnosis.
- Tambahkan satu line helper text: `Insight ini membantu kamu melihat pola, bukan menilai dirimu.`
- Insight ditampilkan berdasarkan pola sederhana dari data mood pengguna.

### Emotional Safety Disclaimer
MoodSpace bukan alat diagnosis medis atau psikologis, melainkan media refleksi diri dan pencatatan suasana hati.

### Component Hierarchy
- `AnalysisScreen`
- `AnalysisHeader`
- `RangeFilterChips`
- `EmotionBreakdownCard`
- `SimpleDonutChart` or `BarBreakdown`
- `InsightCardHubungan`
- `InsightCardKepribadian`
- `SupportiveFooterNote`
- `BottomNav`

## 2.4 Statistik

### Screen Goal
Menampilkan tren dan pola mood secara kuantitatif dengan cara yang tetap ringan.

### Content Blocks
- Mood trends
- Most frequent mood
- Activity impact on mood
- Check-in consistency

### Suggested Layout
1. Header title
2. Weekly/monthly toggle
3. Mood trend line chart
4. Most frequent mood card
5. Activity impact chart
6. Check-in consistency card

### UI Elements
- Toggle switch:
  - `Mingguan`
  - `Bulanan`
- Mood summary card:
  - Vertical rounded mood bars
  - Tiap batang mewakili mood
- Most frequent mood:
  - Icon tren/statistik
  - label
  - line chart
- Activity impact:
  - Title 
  - Deskripsi insight
  - Button
- Check-in consistency:
  - `Mood kamu paling stabil pada hari dengan energi tinggi dan tidur cukup.`

### UX Notes
- Fokus pada informasi yang bisa ditindaklanjuti user.
- Hindari terlalu banyak angka mentah.

### Component Hierarchy
- `StatisticsScreen`
- `StatisticsHeader`
- `TimeframeToggle`
- `MoodTrendChartCard`
- `MostFrequentMoodCard`
- `ActivityImpactCard`
- `SummaryInsightCard`
- `BottomNav`

## 2.5 Pengaturan

### Screen Goal
Menyediakan pengaturan inti dengan tampilan sederhana dan bersih.

### Content Blocks
- Profile
- Notifications
- Daily reminders
- Privacy & security
- Data export
- Reset Data
- MoodSpace Assistant
- About the app
- Privacy policy
- Contact us

### Suggested Layout
1. Header title
2. Profile summary card
3. Settings list groups
4. Secondary help/disclaimer area

### UI Elements
- Profile row:
  - avatar
  - name
  - deskripsi
- Settings items:
  - `Notifikasi`
  - `Pengingat Harian`
  - `Privasi & Keamanan`
  - `Export Data`
  - `Reset Data`
  - `MoodSpace Assistant`
  - `Tentang Aplikasi`
  - `Kebijakan Privasi`
  - `Hubungi Kami`

### UX Notes
- Gunakan grouped list dengan ikon sederhana.
- Item destruktif seperti hapus data harus dipisahkan visualnya.
- Pengguna dapat mengatur waktu pengingat harian menggunakan time picker sederhana.

### Component Hierarchy
- `SettingsScreen`
- `SettingsHeader`
- `ProfileCard`
- `SettingsGroupList`
- `SettingsRow`
- `DestructiveActionRow`
- `BottomNav`

## 2.6 Detail Mood 

### Screen Goal
Menjadi alur utama pencatatan mood yang cepat, jelas, dan nyaman secara emosional.

### Primary Prompt
`Bagaimana perasaanmu hari ini?`

### Content Blocks
- Header dengan tombol kembali
- Ilustrasi / ikon mood utama
- Pilihan detail emosi
- Pilihan tingkat energi
- Pilihan aktivitas harian
- Catatan harian opsional
- Tombol simpan mood

### Suggested Layout
1. Top Navigation
2. Mood Illustration
3. Main Prompt
4. Detail Emotion Chips
5. Energy Selector
6. Activity Tags
7. Daily Notes
8. Sticky Save Button

### UI Elements
- Mood Detail Chips:
  - Rounded full capsule
  - Background
  - Shadow soft/light
  - Font semi-bold
- Energy Selector:
  - Segmented selection style
  - Hanya satu pilihan aktif
  - Menggunakan icon baterai pada tiap opsi
- Activity tags:
  - Wrap chips layout
  - Multiple selection allowed
  - Support custom activity melalui chip + Lainnya
- Notes Field:
  - Rounded large textarea
  - Keyboard-safe spacing
- Save Button:
  - Rounded radius besar
  - Sticky bottom spacing

### Interaction Rules
- Mood wajib dipilih sebelum save aktif.
- Notes bersifat opsional.
- Multiple activity tags diperbolehkan.
- Setelah save, tampilkan feedback singkat lalu kembali ke Beranda atau tetap dengan state sukses.

### UX Notes
- Screen ini harus sangat fokus, jangan beri distraksi.
- Keyboard tidak boleh menutupi CTA saat user menulis notes.
- Gunakan animasi halus saat chip dipilih
- Semua elemen menggunakan rounded aesthetic konsisten dengan MoodSpace

### Component Hierarchy
- `LogMoodScreen`
- `TopBarBack`
- `PromptSection`
- `MoodSelector`
- `NotesInput`
- `ActivityTagSelector`
- `SaveMoodButton`

## 2.7 MoodSpace Assistant

### Screen Goal
Menyediakan ruang percakapan suportif yang membantu pengguna melakukan refleksi emosi secara ringan dan nyaman.

### Content Blocks
- Greeting message
- Chat conversation area
- Suggested prompts
- Message input field
- Emotional support disclaimer

### Suggested Layout
1. Header dengan back button
2. Intro supportive text
3. Chat messages area
4. Suggested prompt chips
5. Text input + send button

### UI Elements
- Greeting:
  `Hai, aku siap menemanimu hari ini`

- Input placeholder:
  `Tulis perasaanmu...`

### UX Notes
- Chatbot harus menggunakan bahasa suportif dan netral.
- Hindari respon yang menghakimi atau terlalu formal.
- Chatbot tidak memberikan diagnosis medis atau psikologis.
- Fokus utama adalah membantu pengguna merasa didengar dan lebih tenang.

### Component Hierarchy
- `AssistantScreen`
- `AssistantHeader`
- `ChatBubble`
- `PromptChips`
- `MessageInputBar`
- `SupportiveDisclaimer`

## 3. Design System

## 3.1 Color Palette

### Brand Base
- `bg.base`: `#FFFDF8`
- `bg.surface`: `#FFFFFF`
- `bg.soft`: `#F7F4EF`
- `border.soft`: `#E8E1D8`
- `text.primary`: `#2F2A24`
- `text.secondary`: `#6F675F`

### Accent Palette
- `accent.peach`: `#F6C7B6`
- `accent.sage`: `#BFD8C1`
- `accent.sky`: `#C9DDF2`
- `accent.lavender`: `#D9CFF2`
- `accent.butter`: `#F6E3A1`

### Emotion-Based Color Mapping
- `mood.very-bad`: `#E8A4A4`
- `mood.bad`: `#F2C2A8`
- `mood.neutral`: `#F3DE9B`
- `mood.good`: `#BFE0B7`
- `mood.very-good`: `#9ED4C8`

### Semantic
- `success`: `#A9D8B8`
- `warning`: `#F3D8A6`
- `danger.soft`: `#E7B6B6`
- `info.soft`: `#C9DDF2`

## 3.2 Typography

### Font Recommendation
- Heading: `DM Sans`
- Body: `Inter`

### Type Scale
- `display-lg`: 32 / 40 / 700
- `heading-xl`: 24 / 32 / 700
- `heading-lg`: 20 / 28 / 600
- `heading-md`: 18 / 24 / 600
- `body-lg`: 16 / 24 / 400
- `body-md`: 14 / 20 / 400
- `body-sm`: 12 / 16 / 400
- `label-md`: 14 / 18 / 500

## 3.3 Spacing System
Gunakan 8pt grid:
- `space-4`: 4
- `space-8`: 8
- `space-12`: 12
- `space-16`: 16
- `space-24`: 24
- `space-32`: 32
- `space-40`: 40
- `space-48`: 48

## 3.4 Radius
- `radius-sm`: 8
- `radius-md`: 12
- `radius-lg`: 16
- `radius-xl`: 24
- `radius-pill`: 999

## 3.5 Component Style Direction
- Cards: soft shadow sangat halus, rounded large.
- Buttons: rounded pill atau rounded large.
- Inputs: border lembut, focus state jelas namun tidak agresif.
- Chips: filled soft pastel atau outline lembut.

## 4. Interaction Design

### Tab Navigation
- Gunakan transisi halus antar tab, durasi 180-240ms.
- Pertahankan posisi konten bila user kembali ke tab sebelumnya.

### Mood Selection
- Saat mood dipilih:
  - emoji/icon sedikit membesar 1.05x
  - muncul glow atau soft highlight
  - berikan haptic feedback ringan

### Save Action
- Tombol save memberi pressed state yang jelas.
- Setelah save:
  - tampilkan toast atau inline success
  - animasi fade/slide singkat

### Emotional Comfort Rules
- Hindari animasi bounce berlebihan.
- Hindari warna flash keras.
- Seluruh interaksi harus terasa lembut dan menenangkan.

## 5. Data Visualization Guidelines

### General Rules
- Maksimal 1 insight utama per card.
- Gunakan warna lembut dan gridline minimal.
- Pastikan chart tetap terbaca dalam ukuran mobile.

### Chart Types
- Mood trends: line chart sederhana
- Emotional breakdown: donut kecil atau horizontal bar
- Activity impact: horizontal bars
- Frequent mood: highlight card, bukan chart besar

### Chart Styling
- Gridlines tipis atau seminimal mungkin.
- Label langsung dekat data bila memungkinkan.
- Hindari legend yang terlalu jauh dari chart.

## 6. UX Writing Guidelines

### Tone
- Ramah
- Suportif
- Netral
- Tidak menghakimi

### Example Copy
- `Bagaimana perasaanmu hari ini?`
- `Tidak perlu panjang, cukup catat yang penting.`
- `Terima kasih sudah meluangkan waktu untuk dirimu hari ini.`
- `Kamu bisa melihat pola emosimu secara perlahan dari sini.`

### Avoid
- `Kamu harus konsisten`
- `Mood kamu buruk hari ini`
- `Kamu gagal check-in`

Gunakan alternatif:
- `Belum sempat check-in hari ini`
- `Coba catat perasaanmu saat kamu siap`

## 7. Developer-Oriented Component Map

### Shared Components
- `AppScaffold`
- `BottomNavBar`
- `TopAppBar`
- `PrimaryButton`
- `SecondaryButton`
- `MoodEmojiButton`
- `MoodSlider`
- `TagChip`
- `InsightCard`
- `ChartCard`
- `ListRow`
- `SectionHeader`
- `ToastSuccess`
- `EmptyState`

### State Requirements
Setiap screen minimal punya state:
- Default
- Loading
- Empty
- Error

Tambahan:
- Beranda: `alreadyLoggedToday`
- Kalender: `noEntryForSelectedDate`
- Detail Mood: `saveDisabled`, `saving`, `saved`
- Statistik: `insufficientData`
- Analisis: `insufficientData`

## 8. Product Foundations & Requirements

## 8.1 Product Goals
- Meningkatkan frekuensi mood check-in harian
- Membantu user mengenali pola emosi
- Menyediakan insight yang actionable tanpa overwhelm

## 8.2 Target Users
- Mahasiswa (18–24) dengan stress akademik
- Young professionals dengan burnout ringan
- User yang ingin journaling sederhana tanpa kompleksitas

## 8.3 Success Metrics
- Daily Active Users (DAU)
- Mood check-in rate per user per week
- Retention 7 hari
- Completion rate log mood

## 8.4 Functional Requirements
- User dapat menyimpan 1 mood per hari
- Data mood saat ini disimpan secara lokal pada perangkat pengguna
- Kalender menampilkan mood berdasarkan tanggal
- Statistik dihitung dari mood history
- Pengguna dapat mengakses halaman Kebijakan dan Privasi melalui Pengaturan

## 8.5 Edge Cases
- Tidak ada data → tampilkan empty state
- User belum log mood → CTA berubah
- Data kosong di statistik → tampilkan placeholder insight

## 8.6 Constraints
- Platform: Flutter (mobile-first)
- Tidak menggunakan chart library berat

## 9. Final Recommendation
Pertahankan fokus aplikasi ini pada satu tindakan inti: membantu user mengenali dan mencatat emosinya dengan cepat dan aman. Navigation yang sudah ada sudah cukup jelas; nilai tambah utama harus datang dari kejelasan visual, copy yang suportif, dan insight yang sederhana namun terasa personal.
