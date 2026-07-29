-- ============================================================
--  TelcoU · Sistema de Capacitaciones
--  Ejecuta este script en: Supabase → SQL Editor → New query
-- ============================================================

-- Tabla principal de asignaciones de capacitación
CREATE TABLE IF NOT EXISTS asignaciones (
  id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW(),

  -- Personal
  user_login      TEXT NOT NULL,
  nombre          TEXT NOT NULL,
  equipo          TEXT NOT NULL CHECK (equipo IN ('Planificación','Implementación','O&M')),

  -- Curso
  curso_id        BIGINT,
  curso_titulo    TEXT,
  institucion     TEXT DEFAULT 'UDEMY',
  horas_curso     NUMERIC,

  -- Planificación
  fecha_inicio    DATE,
  fecha_fin       DATE,
  fecha_fin_real  DATE,
  prioridad       TEXT DEFAULT 'Media' CHECK (prioridad IN ('Alta','Media','Baja')),
  modalidad       TEXT DEFAULT 'Online' CHECK (modalidad IN ('Online','Presencial','Blended')),
  objetivo        TEXT DEFAULT 'Técnico',
  aprobado_por    TEXT,

  -- Seguimiento
  estado          TEXT DEFAULT 'En curso' CHECK (estado IN ('En curso','Culminado','Inicia cuando termine el anterior','Cancelado','Suspendido')),
  avance          SMALLINT DEFAULT 0 CHECK (avance >= 0 AND avance <= 100),
  certificado     TEXT CHECK (certificado IN ('SI','NO','') OR certificado IS NULL),
  nota            NUMERIC(5,2),

  -- Licencia y costo
  licencia        TEXT DEFAULT 'Telco U',
  licencia_pertenece TEXT,
  costo           NUMERIC(10,2),

  -- Evaluación post-capacitación
  evaluacion_aprobada BOOLEAN,
  nota_evaluacion NUMERIC(5,2),
  fecha_vence_cert DATE,

  -- Notas
  observaciones   TEXT
);

-- Índices útiles
CREATE INDEX IF NOT EXISTS idx_asig_equipo   ON asignaciones(equipo);
CREATE INDEX IF NOT EXISTS idx_asig_user     ON asignaciones(user_login);
CREATE INDEX IF NOT EXISTS idx_asig_estado   ON asignaciones(estado);
CREATE INDEX IF NOT EXISTS idx_asig_curso_id ON asignaciones(curso_id);

-- Auto-update de updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_updated_at ON asignaciones;
CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON asignaciones
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ────────────────────────────────────────────────────────────────
--  ROW LEVEL SECURITY (opcional pero recomendado)
--  Habilitar solo si usas autenticación de Supabase Auth
-- ────────────────────────────────────────────────────────────────
-- ALTER TABLE asignaciones ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "acceso_publico" ON asignaciones FOR ALL USING (true);

-- ────────────────────────────────────────────────────────────────
--  DATOS INICIALES — primeras 3 asignaciones del archivo Excel
-- ────────────────────────────────────────────────────────────────
INSERT INTO asignaciones
  (user_login, nombre, equipo, institucion, fecha_inicio, fecha_fin, avance, estado, certificado, horas_curso, licencia, observaciones, prioridad)
VALUES
  ('hchiluisa','Chiluisa Lopez Haydi Guissela','Planificación','UDEMY','2026-03-27','2026-04-06',100,'Culminado','SI',2,'Telco U','SI','Alta'),
  ('raacosta','Acosta Mato Romina Alexandra','Planificación','UDEMY',NULL,NULL,40,'En curso','NO',3,'Interna','PENDIENTE','Media'),
  ('cdalmeida','Almeida Chicaiza Christian David','Planificación','UDEMY',NULL,NULL,0,'Inicia cuando termine el anterior',NULL,NULL,NULL,NULL,'Baja');
