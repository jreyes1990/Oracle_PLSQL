CREATE OR REPLACE TRIGGER TRG_I_HECHOS
BEFORE INSERT
ON HECHOS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   V_VALOR 	    VALORES_DEFAULT.VALOR%TYPE;
BEGIN
    IF INSERTING THEN
        IF :NEW.PESO_TOTAL IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('PESO_TOTAL', V_VALOR);
            :NEW.PESO_TOTAL := V_VALOR;
        ELSIF :NEW.VALOR_DOLARES IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('VALOR_DOLARES', V_VALOR);
            :NEW.VALOR_DOLARES := V_VALOR;
        ELSIF :NEW.VALOR_QUETZALES IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('VALOR_QUETZALES', V_VALOR);
            :NEW.VALOR_QUETZALES := V_VALOR;
        ELSIF :NEW.VALOR_FLETES IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('VALOR_FLETES', V_VALOR);
            :NEW.VALOR_FLETES := V_VALOR;
        ELSIF :NEW.VALOR_SEGUROS IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('VALOR_SEGUROS', V_VALOR);
            :NEW.VALOR_SEGUROS := V_VALOR;
        ELSIF :NEW.VALOR_OTROS_GASTOS IS NULL THEN
            V_VALOR := FNC_DEVUELVE_VALOR_DEFAULT('VALOR_OTROS_GASTOS', V_VALOR);
            :NEW.VALOR_OTROS_GASTOS := V_VALOR;
        END IF;
    END IF;
    
END TRG_I_HECHOS;