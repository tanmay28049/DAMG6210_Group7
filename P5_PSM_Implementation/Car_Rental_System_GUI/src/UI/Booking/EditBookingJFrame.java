/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package UI.Booking;

import UI.DatabaseConnection;
import javax.swing.*;
import java.sql.*;

/**
 *
 * @author AnjanaSruthiR
 */
public class EditBookingJFrame extends javax.swing.JFrame {

    private final ManageBookingsJFrame parent;
    private final int bookingID;

    /**
     * Creates new form EditBookingJFrame
     */
    public EditBookingJFrame(ManageBookingsJFrame parent, int bookingID) {
        initComponents();
        this.parent = parent;
        this.bookingID = bookingID;
        loadComboBoxes(); // Populate the combo boxes
        loadBookingDetails(); // Load the existing booking details    
    }

    private void loadBookingDetails() {
        String query = "SELECT * FROM Booking WHERE BookingID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, bookingID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                TxtBookingDate.setText(rs.getDate("BookingDate").toString());
                TxtStartDate.setText(rs.getDate("StartDate").toString());
                TxtEndDate.setText(rs.getDate("EndDate").toString());
                TxtTotalAmount.setText(String.valueOf(rs.getDouble("TotalAmount")));
                CmbStatus.setSelectedItem(rs.getString("BookingStatus"));
                CmbCustomerID.setSelectedItem(rs.getInt("CustomerID") + " - " + getCustomerName(rs.getInt("CustomerID")));
                CmbVehicleID.setSelectedItem(rs.getInt("Vehicle_ID") + " - " + getVehicleName(rs.getInt("Vehicle_ID")));
                CmbInsuranceID.setSelectedItem(rs.getInt("Insurance_ID") + " - " + getInsuranceProvider(rs.getInt("Insurance_ID")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error loading booking details: " + e.getMessage());
        }
    }

    private void loadComboBoxes() {
        loadCustomerComboBox();
        loadVehicleComboBox();
        loadInsuranceComboBox();
    }

    private void loadCustomerComboBox() {
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT Customer_PersonID, FirstName, LastName FROM Customer JOIN Person ON Customer_PersonID = PersonID")) {
            ResultSet rs = stmt.executeQuery();
            CmbCustomerID.removeAllItems(); // Clear previous items
            CmbCustomerID.addItem("Select--");
            while (rs.next()) {
                CmbCustomerID.addItem(rs.getInt("Customer_PersonID") + " - " + rs.getString("FirstName") + " " + rs.getString("LastName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error Loading Customers: " + e.getMessage());
        }
    }

    private void loadVehicleComboBox() {
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT Vehicle_ID, Vehicle_Brand, Vehicle_Model FROM Vehicle")) {
            ResultSet rs = stmt.executeQuery();
            CmbVehicleID.removeAllItems(); // Clear previous items
            CmbVehicleID.addItem("Select--");
            while (rs.next()) {
                CmbVehicleID.addItem(rs.getInt("Vehicle_ID") + " - " + rs.getString("Vehicle_Brand") + " " + rs.getString("Vehicle_Model"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error Loading Vehicles: " + e.getMessage());
        }
    }

    private void loadInsuranceComboBox() {
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT Insurance_ID, Insurance_Provider FROM Insurance")) {
            ResultSet rs = stmt.executeQuery();
            CmbInsuranceID.removeAllItems(); // Clear previous items
            CmbInsuranceID.addItem("Select--");
            while (rs.next()) {
                CmbInsuranceID.addItem(rs.getInt("Insurance_ID") + " - " + rs.getString("Insurance_Provider"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error Loading Insurance: " + e.getMessage());
        }
    }

    private String getCustomerName(int customerID) {
        String query = "SELECT FirstName, LastName FROM Person WHERE PersonID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, customerID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("FirstName") + " " + rs.getString("LastName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }

    private String getVehicleName(int vehicleID) {
        String query = "SELECT Vehicle_Brand, Vehicle_Model FROM Vehicle WHERE Vehicle_ID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, vehicleID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Vehicle_Brand") + " " + rs.getString("Vehicle_Model");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }

    private String getInsuranceProvider(int insuranceID) {
        String query = "SELECT Insurance_Provider FROM Insurance WHERE Insurance_ID = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, insuranceID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Insurance_Provider");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Unknown";
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        BtnBack = new javax.swing.JButton();
        jLabel12 = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        TxtBookingDate = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        TxtStartDate = new javax.swing.JTextField();
        jLabel4 = new javax.swing.JLabel();
        TxtEndDate = new javax.swing.JTextField();
        jLabel11 = new javax.swing.JLabel();
        TxtTotalAmount = new javax.swing.JTextField();
        jLabel10 = new javax.swing.JLabel();
        CmbCustomerID = new javax.swing.JComboBox<>();
        jLabel9 = new javax.swing.JLabel();
        CmbVehicleID = new javax.swing.JComboBox<>();
        BtnUpdate = new javax.swing.JButton();
        BtnCancel = new javax.swing.JButton();
        jLabel13 = new javax.swing.JLabel();
        CmbInsuranceID = new javax.swing.JComboBox<>();
        jLabel14 = new javax.swing.JLabel();
        CmbStatus = new javax.swing.JComboBox<>();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        BtnBack.setText("<- Back");
        BtnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnBackActionPerformed(evt);
            }
        });

        jLabel12.setFont(new java.awt.Font("Helvetica Neue", 1, 18)); // NOI18N
        jLabel12.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel12.setText("Edit Booking details");

        jLabel1.setText("Booking Date");

        TxtBookingDate.setEditable(false);

        jLabel3.setText("Start Date (yyyy-mm-dd)");

        jLabel4.setText("End Date (yyyy-mm-dd)");

        jLabel11.setText("Total Amount");

        jLabel10.setText("Customer ID");

        CmbCustomerID.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Select--" }));

        jLabel9.setText("Vehicle ID");

        CmbVehicleID.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Select--" }));

        BtnUpdate.setText("Update");
        BtnUpdate.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnUpdateActionPerformed(evt);
            }
        });

        BtnCancel.setText("Cancel");
        BtnCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnCancelActionPerformed(evt);
            }
        });

        jLabel13.setText("Insurance ID");

        CmbInsuranceID.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Select--" }));

        jLabel14.setText("Status");

        CmbStatus.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Select--", "Confirmed", "Pending", "Cancelled", "Completed" }));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(70, 70, 70)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(BtnBack)
                        .addGap(153, 153, 153)
                        .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 339, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(251, 251, 251))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(14, 14, 14)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel11)
                                .addGap(44, 44, 44)
                                .addComponent(TxtTotalAmount, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1)
                                .addGap(44, 44, 44)
                                .addComponent(TxtBookingDate, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel3)
                                .addGap(44, 44, 44)
                                .addComponent(TxtStartDate, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel4)
                                .addGap(44, 44, 44)
                                .addComponent(TxtEndDate, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel13)
                            .addComponent(jLabel10)
                            .addComponent(jLabel9)
                            .addComponent(jLabel14))
                        .addGap(44, 44, 44)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(CmbStatus, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(CmbVehicleID, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(CmbCustomerID, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(CmbInsuranceID, javax.swing.GroupLayout.PREFERRED_SIZE, 165, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addGap(86, 86, 86))))
            .addGroup(layout.createSequentialGroup()
                .addGap(345, 345, 345)
                .addComponent(BtnUpdate)
                .addGap(54, 54, 54)
                .addComponent(BtnCancel)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(52, 52, 52)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(BtnBack)
                    .addComponent(jLabel12, javax.swing.GroupLayout.PREFERRED_SIZE, 42, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(50, 50, 50)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel1)
                        .addComponent(TxtBookingDate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel14, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addComponent(CmbStatus)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel3)
                            .addComponent(TxtStartDate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(jLabel4)
                            .addComponent(TxtEndDate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(CmbCustomerID)
                            .addComponent(jLabel10, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(CmbVehicleID)
                            .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(jLabel11)
                        .addComponent(TxtTotalAmount, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                        .addComponent(CmbInsuranceID)
                        .addComponent(jLabel13, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(74, 74, 74)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(BtnUpdate)
                    .addComponent(BtnCancel))
                .addContainerGap(302, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnBackActionPerformed
        this.dispose();
        parent.setVisible(true);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnBackActionPerformed

    private void BtnUpdateActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnUpdateActionPerformed
        if (!validateFields()) {
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            String updateSQL = "UPDATE Booking SET StartDate = ?, EndDate = ?, TotalAmount = ?, BookingStatus = ?, CustomerID = ?, Vehicle_ID = ?, Insurance_ID = ? WHERE BookingID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateSQL)) {
                stmt.setDate(1, java.sql.Date.valueOf(TxtStartDate.getText()));
                stmt.setDate(2, java.sql.Date.valueOf(TxtEndDate.getText()));
                stmt.setDouble(3, Double.parseDouble(TxtTotalAmount.getText()));
                stmt.setString(4, (String) CmbStatus.getSelectedItem());
                stmt.setInt(5, Integer.parseInt(CmbCustomerID.getSelectedItem().toString().split(" - ")[0]));
                stmt.setInt(6, Integer.parseInt(CmbVehicleID.getSelectedItem().toString().split(" - ")[0]));
                stmt.setInt(7, Integer.parseInt(CmbInsuranceID.getSelectedItem().toString().split(" - ")[0]));
                stmt.setInt(8, bookingID);

                stmt.executeUpdate();
                JOptionPane.showMessageDialog(this, "Booking updated successfully.");
                parent.loadBookingData();
                this.dispose();
                parent.setVisible(true);
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error updating booking: " + e.getMessage());
        }
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnUpdateActionPerformed

    private boolean validateFields() {
        if (TxtStartDate.getText().isEmpty() || TxtEndDate.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "Start Date and End Date are required.");
            return false;
        }
        if (CmbCustomerID.getSelectedItem().equals("Select--")
                || CmbVehicleID.getSelectedItem().equals("Select--")
                || CmbInsuranceID.getSelectedItem().equals("Select--")) {
            JOptionPane.showMessageDialog(this, "Please select valid Customer, Vehicle, and Insurance.");
            return false;
        }
        try {
            double totalAmount = Double.parseDouble(TxtTotalAmount.getText());
            if (totalAmount <= 0) {
                JOptionPane.showMessageDialog(this, "Total Amount must be greater than 0.");
                return false;
            }
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "Please enter a valid Total Amount.");
            return false;
        }
        return true;
    }


    private void BtnCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnCancelActionPerformed
        this.dispose();
        parent.setVisible(true);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnCancelActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(EditBookingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(EditBookingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(EditBookingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(EditBookingJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> {
            ManageBookingsJFrame manageBookingsFrame = new ManageBookingsJFrame(null);
            new EditBookingJFrame(manageBookingsFrame, 1).setVisible(true); // Replace 1 with a valid BookingID for testing
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton BtnBack;
    private javax.swing.JButton BtnCancel;
    private javax.swing.JButton BtnUpdate;
    private javax.swing.JComboBox<String> CmbCustomerID;
    private javax.swing.JComboBox<String> CmbInsuranceID;
    private javax.swing.JComboBox<String> CmbStatus;
    private javax.swing.JComboBox<String> CmbVehicleID;
    private javax.swing.JTextField TxtBookingDate;
    private javax.swing.JTextField TxtEndDate;
    private javax.swing.JTextField TxtStartDate;
    private javax.swing.JTextField TxtTotalAmount;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel9;
    // End of variables declaration//GEN-END:variables
}
