/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ece356;

/**
 *
 * @author sekharb
 */
public class FriendRequest {
    public String patient_alias;
    public String email;
    
    public FriendRequest(String patient_alias, String email) {
        this.patient_alias = patient_alias;
        this.email = email;
    }
    
    public String getPatientAlias() {
        return this.patient_alias;
    }
    
    public String getEmail() {
        return this.getEmail();
    }
}
