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
public class Specialization {
    private String doctor_alias;
    private String specialization_name;
    
    public Specialization(String doctor_alias, String specialization_name) {
        this.doctor_alias = doctor_alias;
        this.specialization_name = specialization_name;
    }
    
    public String getDoctorAlias() {
        return this.doctor_alias;
    }
    
    public String getSpecializationName() {
        return this.specialization_name;
    }
}
