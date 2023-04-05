-- Create or replace the package specification
CREATE OR REPLACE PACKAGE Auth_Package IS

  FUNCTION register_user(username IN VARCHAR2, password IN VARCHAR2) RETURN BOOLEAN;
  FUNCTION login_user(username IN VARCHAR2, password IN VARCHAR2) RETURN BOOLEAN;
  FUNCTION is_user_authenticated RETURN BOOLEAN;
  PROCEDURE logout_user;
END Auth_Package;

/
-- Create or replace the package body
CREATE OR REPLACE PACKAGE BODY Auth_Package IS

  -- Private variables
  current_user_id MM_Users.user_id%TYPE;
  is_authenticated BOOLEAN := FALSE;

  FUNCTION register_user(username IN VARCHAR2, password IN VARCHAR2) RETURN BOOLEAN IS
    user_id MM_Users.User_id%TYPE;
    BEGIN
      -- Check if username already exists
      SELECT User_id INTO user_id FROM MM_Users WHERE UserName = username;
      IF user_id IS NOT NULL THEN
        RETURN FALSE;
      END IF;

      -- Insert new user
      INSERT INTO MM_Users (UserName, Password) VALUES (username, password);
      RETURN TRUE;
    END;

  FUNCTION login_user(username IN VARCHAR2, password IN VARCHAR2) RETURN BOOLEAN IS
    user_id MM_Users.User_id%TYPE;
    BEGIN
      -- Check if user exists
      SELECT User_id INTO user_id FROM MM_Users WHERE UserName = username AND Password = password;
      IF user_id IS NULL THEN
        RETURN FALSE;
      END IF;

      -- Set current user and mark as authenticated
      current_user_id := user_id;
      is_authenticated := TRUE;

      RETURN TRUE;
    END;

  FUNCTION is_user_authenticated RETURN BOOLEAN IS
    BEGIN
      RETURN is_authenticated;
    END;

  PROCEDURE logout_user IS
    BEGIN
      -- Clear current user and mark as not authenticated
      current_user_id := NULL;
      is_authenticated := FALSE;
    END;
END Auth_Package;
/
