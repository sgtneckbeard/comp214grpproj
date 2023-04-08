import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.*;

// To do:
// Add procedure from 7.1 package MM_MANAGER_PKG

public class SwingUI {
    private JPanel mainPanel;
    private JTextArea dbmsOutputTextArea;
    private JButton fetchTop5Button;
    private JButton clearButton;
    private JButton getMoviesByGenreButton;
    private JComboBox genrebox;

    public SwingUI() {

        dbmsOutputTextArea.setFont(new Font("Comic Sans MS", Font.BOLD, 14));
        dbmsOutputTextArea.setEditable(false);
        dbmsOutputTextArea.setToolTipText("Please make a selection below");

        fetchTop5Button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                displayDbmsOutput();
            }
        });

        getMoviesByGenreButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String genre = (String) genrebox.getSelectedItem();
                displayMoviesByGenre(genre);
            }
        });
        genrebox.addItem("Drama");
        genrebox.addItem("Adventure");
        genrebox.addItem("Action");
        genrebox.addItem("Crime");
        genrebox.addItem("Comedy");
        genrebox.addItem("omedy");

        clearButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dbmsOutputTextArea.setText("");
            }
        });

        mainPanel.setPreferredSize(new Dimension(800, 600));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

    }

    private void displayDbmsOutput() {
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "secret");

            CallableStatement enableDbmsOutput = connection.prepareCall("BEGIN DBMS_OUTPUT.ENABLE(NULL); END;");
            enableDbmsOutput.execute();
            enableDbmsOutput.close();

            CallableStatement callableStatement = connection.prepareCall("{call get_top_5}");
            callableStatement.execute();
            callableStatement.close();

            CallableStatement getDbmsOutput = connection.prepareCall("DECLARE " +
                    "l_line VARCHAR2(32767);" +
                    "l_done NUMBER;" +
                    "l_buffer LONG;" +
                    "BEGIN " +
                    "LOOP " +
                    "EXIT WHEN LENGTH(l_buffer)+255 > :maxbytes OR l_done = 1;" +
                    "DBMS_OUTPUT.GET_LINE(l_line, l_done);" +
                    "l_buffer := l_buffer || l_line || chr(10);" +
                    "END LOOP;" +
                    ":buffer := l_buffer;" +
                    "END;");
            getDbmsOutput.registerOutParameter(1, Types.INTEGER);
            getDbmsOutput.registerOutParameter(2, Types.VARCHAR);
            getDbmsOutput.setInt(1, 32000);
            getDbmsOutput.executeUpdate();
            String dbmsOutput = getDbmsOutput.getString(2);
            getDbmsOutput.close();

            connection.close();

            dbmsOutputTextArea.setText(dbmsOutput);
        } catch (SQLException e) {
            StringWriter errors = new StringWriter();
            e.printStackTrace(new PrintWriter(errors));
            dbmsOutputTextArea.setText("Exception: " + errors.toString());
        }

    }

    private void displayMoviesByGenre(String genre) {
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "secret");

            CallableStatement callableStatement = connection.prepareCall("{? = call get_movies_by_genre(?)}");
            callableStatement.registerOutParameter(1, OracleTypes.CURSOR);
            callableStatement.setString(2, genre);
            callableStatement.execute();

            ResultSet resultSet = ((OracleCallableStatement) callableStatement).getCursor(1);
            StringBuilder output = new StringBuilder();
            while (resultSet.next()) {
                output.append(resultSet.getString(1)).append("\n");
            }

            resultSet.close();
            callableStatement.close();
            connection.close();

            dbmsOutputTextArea.setText(output.toString());
        } catch (SQLException e) {
            dbmsOutputTextArea.setText(e.getMessage());
        }
    }

    public static void main(String[] args) {
        SwingUI swingUI = new SwingUI();
        JFrame frame = new JFrame("Welcome to MM_Movies");
        frame.setContentPane(swingUI.mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        frame.setPreferredSize(new Dimension(600, 400));
        frame.setMinimumSize(new Dimension(600, 400));

        frame.pack();
        frame.setVisible(true);
    }
}
