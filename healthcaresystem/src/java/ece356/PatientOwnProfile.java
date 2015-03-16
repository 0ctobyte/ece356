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
public class PatientOwnProfile {
    private String patient_alias;
    private String email;
    private String name_first;
    private String name_middle;
    private String name_last;
    private String city;
    private String province;
    
    public PatientOwnProfile(String patient_alias, String email, String name_first, String name_middle, String name_last, String city, String province) {
        this.patient_alias = patient_alias;
        this.email = email;
        this.name_first = name_first;
        this.name_middle = name_middle;
        this.name_last = name_last;
        this.city = city;
        this.province = province;
    }
    
    public String getPatientAlias() {
        return this.patient_alias;
    }
    
    public String getEmail() {
        return this.email;
    }
    
    public String getFirstName() {
        return this.name_first;
    }
    
    public String getMiddleName() {
        return this.name_middle;
    }
    
    public String getLastName() {
        return this.name_last;
    }
    
    public String getCity() {
        return this.city;
    }
    
    public String getProvince() {
        return this.province;
    }
}
