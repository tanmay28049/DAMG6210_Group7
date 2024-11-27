/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package UI;

import UI.Booking.ManageBookingsJFrame;
import UI.Customer.ManageCustomersJFrame;
import UI.Feedback.ViewFeedbackJFrame;
import UI.Vehicle.ManageVehiclesJFrame;
import javax.swing.JOptionPane;

/**
 *
 * @author AnjanaSruthiR
 */
public class MainMenuJFrame extends javax.swing.JFrame {

    /**
     * Creates new form MainMenuJFrame
     */
    public MainMenuJFrame() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        BtnManageCustomers = new javax.swing.JButton();
        BtnManageVehicles = new javax.swing.JButton();
        BtnManageBookings = new javax.swing.JButton();
        BtnViewFeedback = new javax.swing.JButton();
        BtnLogout = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        BtnManageCustomers.setText("Manage Customers");
        BtnManageCustomers.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnManageCustomersActionPerformed(evt);
            }
        });

        BtnManageVehicles.setText("Manage Vehicles");
        BtnManageVehicles.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnManageVehiclesActionPerformed(evt);
            }
        });

        BtnManageBookings.setText("Manage Bookings");
        BtnManageBookings.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnManageBookingsActionPerformed(evt);
            }
        });

        BtnViewFeedback.setText("View Feedback");
        BtnViewFeedback.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnViewFeedbackActionPerformed(evt);
            }
        });

        BtnLogout.setText("Log Out");
        BtnLogout.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                BtnLogoutActionPerformed(evt);
            }
        });

        jLabel1.setFont(new java.awt.Font("Helvetica Neue", 1, 18)); // NOI18N
        jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel1.setText("Car Rental System - Admin Dashboard");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(BtnViewFeedback)
                    .addComponent(BtnManageBookings)
                    .addComponent(BtnManageVehicles)
                    .addComponent(BtnManageCustomers))
                .addGap(109, 109, 109))
            .addGroup(layout.createSequentialGroup()
                .addGap(55, 55, 55)
                .addComponent(BtnLogout)
                .addGap(56, 56, 56)
                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 394, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(204, Short.MAX_VALUE))
        );

        layout.linkSize(javax.swing.SwingConstants.HORIZONTAL, new java.awt.Component[] {BtnManageBookings, BtnManageCustomers, BtnManageVehicles, BtnViewFeedback});

        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(38, 38, 38)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(BtnLogout)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 49, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(109, 109, 109)
                .addComponent(BtnManageCustomers)
                .addGap(18, 18, 18)
                .addComponent(BtnManageVehicles)
                .addGap(18, 18, 18)
                .addComponent(BtnManageBookings)
                .addGap(18, 18, 18)
                .addComponent(BtnViewFeedback)
                .addContainerGap(210, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void BtnManageCustomersActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnManageCustomersActionPerformed
        new ManageCustomersJFrame(this).setVisible(true); // Pass the reference of this frame
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnManageCustomersActionPerformed

    private void BtnManageVehiclesActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnManageVehiclesActionPerformed
        new ManageVehiclesJFrame(this).setVisible(true); // Pass the reference of this frame
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnManageVehiclesActionPerformed

    private void BtnManageBookingsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnManageBookingsActionPerformed
        new ManageBookingsJFrame(this).setVisible(true); // Pass the reference of this frame
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnManageBookingsActionPerformed

    private void BtnViewFeedbackActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnViewFeedbackActionPerformed
        new ViewFeedbackJFrame(this).setVisible(true); // Pass the reference of this frame
        this.setVisible(false);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnViewFeedbackActionPerformed

    private void BtnLogoutActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_BtnLogoutActionPerformed
        this.dispose();
        new LoginJFrame().setVisible(true);
        // TODO add your handling code here:
    }//GEN-LAST:event_BtnLogoutActionPerformed

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
            java.util.logging.Logger.getLogger(MainMenuJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainMenuJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainMenuJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainMenuJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MainMenuJFrame().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton BtnLogout;
    private javax.swing.JButton BtnManageBookings;
    private javax.swing.JButton BtnManageCustomers;
    private javax.swing.JButton BtnManageVehicles;
    private javax.swing.JButton BtnViewFeedback;
    private javax.swing.JLabel jLabel1;
    // End of variables declaration//GEN-END:variables
}