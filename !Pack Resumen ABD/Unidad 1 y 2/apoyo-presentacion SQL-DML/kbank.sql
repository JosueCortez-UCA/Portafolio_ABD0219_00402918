
DROP TABLE IF EXISTS cuenta;

CREATE TABLE cuenta (
    id SMALLINT GENERATED BY DEFAULT AS IDENTITY,
    nombre VARCHAR(100) NOT NULL,
    balance MONEY NOT NULL,
    CONSTRAINT pk_cuenta PRIMARY KEY(id)
);

INSERT INTO cuenta (nombre,balance) VALUES('Susana',10000);
INSERT INTO cuenta (nombre,balance) VALUES('Jenny',7500);

BEGIN;
INSERT INTO cuenta (nombre,balance) VALUES('Arturo',5000);

-- Abramos otra sesión y veamos si está ingresado el dinero de Arturo
-- No problem, confirmamos transacción
COMMIT;

-- Ahora hagamos una transferencia de 1500 de Susana para Jenny

BEGIN;
UPDATE cuenta 
SET balance = balance - 1500::money
WHERE id = 1;

UPDATE cuenta 
SET balance = balance + 1500::money
WHERE id = 3;

-- Nooo, ¡a Arturo no!: el dinero era para Jenny! Marcha atrás

ROLLBACK;
