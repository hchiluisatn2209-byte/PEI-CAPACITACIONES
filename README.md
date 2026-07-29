# Proyectos Corporativos · Capacitaciones

Aplicativo web de una sola página (`index.html`) para registrar y hacer seguimiento de las capacitaciones del personal, con datos almacenados en **Supabase**.

---

## 🚀 Despliegue rápido

### 1 · Crear proyecto en Supabase
1. Ve a [supabase.com](https://supabase.com) → **New project**
2. Anota la **URL del proyecto** y la **anon public key**  
   *(Proyecto → Settings → API)*

### 2 · Crear las tablas
1. Supabase → **SQL Editor** → **New query**
2. Pega el contenido de `schema.sql` y ejecuta (**Run**)

### 3 · Publicar en GitHub Pages
```bash
git init
git add index.html schema.sql README.md
git commit -m "feat: sistema de capacitaciones Proyectos Corporativos"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/proycorp-capacitaciones.git
git push -u origin main
```
Luego en GitHub → **Settings → Pages → Source: main / root** → Save.  
Tu app estará en `https://TU_USUARIO.github.io/proycorp-capacitaciones/`

### 4 · Primera apertura
Al abrir `index.html` (o la URL de Pages), se muestra la pantalla de configuración:  
- Pega la **URL** y la **anon key** de Supabase → **Conectar**

Las credenciales se guardan en `localStorage`; no se vuelven a pedir en el mismo navegador.

---

## 👥 Perfiles de acceso

| Perfil | Cuenta Gmail | Acceso |
|--------|-------------|--------|
| Admin | — | Ve todo el personal |
| Planificación | hchiluisatn2209@gmail.com | Solo su equipo |
| Implementación | geovanna.naranjo23@gmail.com | Solo su equipo |
| O&M | cralarcontn1607@gmail.com | Solo su equipo |

> **Nota:** el cambio de perfil es manual (menú superior derecho). Para autenticación real con Gmail integra **Supabase Auth** con Google OAuth.

---

## 📋 Campos registrados

| Campo | Descripción |
|-------|-------------|
| Personal / Equipo | Usuario, nombre completo, equipo |
| Curso | Selección del catálogo Udemy (75 cursos) |
| Institución | UDEMY, Coursera, Interna, Otra |
| Fechas | Inicio, fin estimada, fin real |
| Prioridad | Alta / Media / Baja |
| Modalidad | Online / Presencial / Blended |
| Objetivo | Técnico / Certificación / Gestión / Habilidades blandas |
| Estado | En curso / Culminado / En espera / Cancelado / Suspendido |
| Avance | 0–100 % |
| Certificado | SI / NO |
| Licencia | Telco U / Interna / Externa |
| Costo | USD |
| Aprobado por | Nombre del jefe directo |
| Observaciones | Notas libres |

---

## 🗄 Estructura de la base de datos

Ver `schema.sql` — una sola tabla `asignaciones` con todos los campos más índices y trigger de `updated_at`.

---

## 🔧 Tecnologías

- **Frontend:** HTML + CSS + JS puro (sin frameworks, sin build step)
- **Base de datos:** [Supabase](https://supabase.com) (PostgreSQL)
- **Hosting:** GitHub Pages (gratis)
