/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package UI.Vehicle;

import UI.DatabaseConnection;
import UI.MainMenuJFrame;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.sql.*;

/**
 *
 * @author AnjanaSruthiR
 */
public class ManageVehiclesJFrame extends javax.swing.JFrame {

    private final MainMenuJFrame parent;

    /**
     * Creates new form ManageVehiclesJFrame
     */
    public ManageVehiclesJFrame(MainMenuJFrame parent) {
        initComponents();
        this.parent = parent;
        loadVehicleData();
    }

 public void loadVehicleData() {
        DefaultTableModel model = (DefaultTableModel) TblVehicles.getModel();
        model.setRowCount(0);

        String query = "SELECT * FROM Vehicle";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                model.addRow(new Object[]{
                        rs.getString("Vehicle_Type"),
                        rs.getString("Vehicle_Brand"),
                        rs.getString("Vehicle_Model"),
                        rs.getInt("Year_of_Manufacturing"),
                        rs.getString("Licence_Plate"),
                        rs.getString("Fuel_Type"),
                        rs.getString("Drive_Type"),
                        rs.getInt("BranchID")
                });
            }

        } catch (SQLException e) {
            JOptionPane.showMessageDialog(this, "Error loading vehicle data: " + e.getMessage());
        }
    }


    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        BtnAdd = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        BtnEdit = new javax.swing.JButton();
        BtnDelete = new javax.swing.JButton();
        BtnDetails = new javax.swing.JButton();
        JScrollPane = new javax.swing.JScrollPane();
        TblVehicles = new javax.swing.JTable();
        BtnBack = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        BtnAdd.setText("Add");
        BtnAdd.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnAddActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Helvetica Neue", 1, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Manage Vehicles");

        BtnEdit.setText("Edit");
        BtnEdit.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnEditActionPerformed(evt);
            }
        });

        BtnDelete.setText("Delete");
        BtnDelete.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnDeleteActionPerformed(evt);
            }
        });

        BtnDetails.setText("Additional Details");
        BtnDetails.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnDetailsActionPerformed(evt);
            }
        });

        TblVehicles.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {
                {null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null},
                {null, null, null, null, null, null, null, null}
            },
            new String [] {
                "Vehicle Type", "Brand", "Model", "Manufacture Year", "License Plate", "Fuel Type", "Drive Type", "Branch ID"
            }
        ));
        JScrollPane.setViewportView(TblVehicles);

        BtnBack.setText("<-Back");
        BtnBack.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnBackActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(BtnAdd)
                .addGap(18, 18, 18)
                .addComponent(BtnEdit)
                .addGap(30, 30, 30)
                .addComponent(BtnDelete)
                .addGap(18, 18, 18)
                .addComponent(BtnDetails)
                .addGap(47, 47, 47))
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(59, 59, 59)
                        .addComponent(BtnBack)
                        .addGap(72, 72, 72)
                        .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 521, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(JScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 893, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(15, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGap(33, 33, 33)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(BtnBack)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(31, 31, 31)
                .addComponent(JScrollPane, javax.swing.GroupLayout.PREFERRED_SIZE, 441, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 44, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(BtnDetails)
                    .addComponent(BtnDelete)
                    .addComponent(BtnEdit)
                    .addComponent(BtnAdd))
                .addGap(54, 54, 54))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnAddActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnAddActionPerformed
        AddVehiclesJFrame addVehiclesFrame = new AddVehiclesJFrame(this);
        addVehiclesFrame.setVisible(true);
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnAddActionPerformed

    private void BtnEditActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnEditActionPerformed
 int selectedRow = TblVehicles.getSelectedRow();
        if (selectedRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a vehicle to edit.");
            return;
        }

        String vehicleType = TblVehicles.getValueAt(selectedRow, 0).toString();
        String vehicleBrand = TblVehicles.getValueAt(selectedRow, 1).toString();
        String vehicleModel = TblVehicles.getValueAt(selectedRow, 2).toString();
        int year = Integer.parseInt(TblVehicles.getValueAt(selectedRow, 3).toString());
        String licensePlate = TblVehicles.getValueAt(selectedRow, 4).toString();
        String fuelType = TblVehicles.getValueAt(selectedRow, 5).toString();
        String driveType = TblVehicles.getValueAt(selectedRow, 6).toString();
        int branchID = Integer.parseInt(TblVehicles.getValueAt(selectedRow, 7).toString());

        EditVehicleJFrame editFrame = new EditVehicleJFrame(this, vehicleType, vehicleBrand, vehicleModel, year, licensePlate, fuelType, driveType, branchID);
        editFrame.setVisible(true);
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnEditActionPerformed

    private void BtnDeleteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnDeleteActionPerformed
        int selectedRow = TblVehicles.getSelectedRow();
        if (selectedRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a vehicle to delete.");
            return;
        }

        String licensePlate = TblVehicles.getValueAt(selectedRow, 4).toString();
        int confirm = JOptionPane.showConfirmDialog(this, "Are you sure you want to delete this vehicle?", "Confirm Deletion", JOptionPane.YES_NO_OPTION);

        if (confirm == JOptionPane.YES_OPTION) {
            String query = "DELETE FROM Vehicle WHERE Licence_Plate = ?";
            try (Connection conn = DatabaseConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, licensePlate);
                stmt.executeUpdate();
                JOptionPane.showMessageDialog(this, "Vehicle deleted successfully.");
                loadVehicleData();
            } catch (SQLException e) {
                JOptionPane.showMessageDialog(this, "Error deleting vehicle: " + e.getMessage());
            }
        }

        // TODO add your handling code here:
    }//GEN-LAST:event_BtnDeleteActionPerformed

    private void BtnDetailsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnDetailsActionPerformed
        int selectedRow = TblVehicles.getSelectedRow();
        if (selectedRow < 0) {
            JOptionPane.showMessageDialog(this, "Please select a vehicle to view details.");
            return;
        }

        String details = String.format(
                "Vehicle Type: %s%nBrand: %s%nModel: %s%nYear: %d%nLicense Plate: %s%nFuel Type: %s%nDrive Type: %s%nBranch ID: %d",
                TblVehicles.getValueAt(selectedRow, 0),
                TblVehicles.getValueAt(selectedRow, 1),
                TblVehicles.getValueAt(selectedRow, 2),
                Integer.parseInt(TblVehicles.getValueAt(selectedRow, 3).toString()),
                TblVehicles.getValueAt(selectedRow, 4),
                TblVehicles.getValueAt(selectedRow, 5),
                TblVehicles.getValueAt(selectedRow, 6),
                Integer.parseInt(TblVehicles.getValueAt(selectedRow, 7).toString())
        );

        JOptionPane.showMessageDialog(this, details, "Vehicle Details", JOptionPane.INFORMATION_MESSAGE);
    // TODO add your handling code here:
    }//GEN-LAST:event_BtnDetailsActionPerformed

    private void BtnBackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnBackActionPerformed
        this.dispose();
        if (parent != null) {
            parent.setVisible(true);
        }
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnBackActionPerformed

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
            java.util.logging.Logger.getLogger(ManageVehiclesJFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(ManageVehiclesJFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(ManageVehiclesJFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);

        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(ManageVehiclesJFrame.class
                    .getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(() -> {
            new ManageVehiclesJFrame(null).setVisible(true);
        });

    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton BtnAdd;
    private javax.swing.JButton BtnBack;
    private javax.swing.JButton BtnDelete;
    private javax.swing.JButton BtnDetails;
    private javax.swing.JButton BtnEdit;
    private javax.swing.JScrollPane JScrollPane;
    private javax.swing.JTable TblVehicles;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables
}