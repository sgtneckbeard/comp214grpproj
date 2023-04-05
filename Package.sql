CREATE OR REPLACE PACKAGE BODY user_auth_pkg AS
    -- Function to check if a given username and password match a user in the MM_Users table
    FUNCTION authenticate_user(p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN AS
        v_user_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_user_count
        FROM MM_Users
        WHERE username = p_username AND password = p_password;
        
        IF v_user_count > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END authenticate_user;
    
    -- Procedure to register a new user
    PROCEDURE register_user(p_username IN VARCHAR2, p_password IN VARCHAR2, p_email IN VARCHAR2) AS
    BEGIN
        INSERT INTO MM_Users (user_id, username, password, email)
        VALUES (user_id_seq.NEXTVAL, p_username, p_password, p_email);
    END register_user;
    
    -- Procedure to reset a user's password
    PROCEDURE reset_password(p_username IN VARCHAR2, p_new_password IN VARCHAR2) AS
    BEGIN
        UPDATE MM_Users
        SET password = p_new_password
        WHERE username = p_username;
    END reset_password;
    
END user_auth_pkg;
/


-- Register a new user
BEGIN
   user_auth_pkg.register_user('johndoe', 'password123', 'johndoe@example.com');
 	DBMS_OUTPUT.PUT_LINE('Register successful');
   COMMIT;

END;
/

-----------------------------


CREATE OR REPLACE PACKAGE user_auth_pkg AS
    -- Function to check if a given username and password match a user in the MM_Users table
    FUNCTION authenticate_user(p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN;
    
    -- Procedure to register a new user
    PROCEDURE register_user(p_username IN VARCHAR2, p_password IN VARCHAR2, p_email IN VARCHAR2);
    
    -- Procedure to reset a user's password
    PROCEDURE reset_password(p_username IN VARCHAR2, p_new_password IN VARCHAR2);

	FUNCTION login(p_username IN VARCHAR2, p_password IN VARCHAR2)RETURN BOOLEAN;
    
END user_auth_pkg;


CREATE OR REPLACE PACKAGE BODY USER_AUTH_PKG AS
    -- Function to check if a given username and password match a user in the MM_Users table
    FUNCTION authenticate_user(p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN AS
        v_user_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_user_count
        FROM MM_Users
        WHERE username = p_username AND password = p_password;
        
        IF v_user_count > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END authenticate_user;
    
    -- Procedure to register a new user
    PROCEDURE register_user(p_username IN VARCHAR2, p_password IN VARCHAR2, p_email IN VARCHAR2) AS
    BEGIN
        INSERT INTO MM_Users (user_id, username, password, email)
        VALUES (user_id_seq.NEXTVAL, p_username, p_password, p_email);
    END register_user;
    
    -- Procedure to reset a user's password
    PROCEDURE reset_password(p_username IN VARCHAR2, p_new_password IN VARCHAR2) AS
    BEGIN
        UPDATE MM_Users
        SET password = p_new_password
        WHERE username = p_username;
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('User not found: ' || p_username);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to reset password: ' || SQLERRM);
    END reset_password;
    
    -- Function to check if a given username and password match a user in the MM_Users table
    FUNCTION login(p_username IN VARCHAR2, p_password IN VARCHAR2) RETURN BOOLEAN AS
        v_user_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_user_count
        FROM MM_Users
        WHERE username = p_username AND password = p_password;
        
        IF v_user_count > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Failed to login: ' || SQLERRM);
            RETURN FALSE;
    END login;
    
END USER_AUTH_PKG;
/
------------------Test Case for register_user:
BEGIN
    user_auth_pkg.register_user('user2', 'password2', 'user2@example.com');
    DBMS_OUTPUT.PUT_LINE('User registered successfully');
END;

------------------Test Case for reset_password:
BEGIN
    user_auth_pkg.reset_password('user2', 'new_password');
    DBMS_OUTPUT.PUT_LINE('Password reset successful');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to reset password: ' || SQLERRM);
END;

------------------Test Case for authenticate_user:
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := user_auth_pkg.authenticate_user('user1', 'password1');
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Authentication Successful');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Authentication Failed');
    END IF;
END;

------------------Test Case for authenticate_user:
DECLARE
    v_result BOOLEAN;
BEGIN
    v_result := user_auth_pkg.login('user2', 'new_password');
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Login Successful');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Login Failed');
    END IF;
END;














