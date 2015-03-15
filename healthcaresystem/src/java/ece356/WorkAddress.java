package ece356;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author sekharb
 */
public class WorkAddress {
    public String doctor_alias;
    public Integer unit_number;
    public Integer street_number;
    public String street_name;
    public String postal_code;
    public String city;
    public String province;
    
    public WorkAddress(String doctor_alias, Integer unit_number, Integer street_number, String street_name, String postal_code, String city, String province) {
        this.doctor_alias = doctor_alias;
        this.unit_number = unit_number;
        this.street_number = street_number;
        this.street_name = street_name;
        this.postal_code = postal_code;
        this.city = city;
        this.province = province;
    }
    
    public String getDoctorAlias() {
        return this.doctor_alias;
    }
    
    public Integer getUnitNumber() {
        return this.unit_number;
    }
    
    public Integer getStreetNumber() {
        return this.street_number;
    }
    
    public String getStreetName() {
        return this.street_name;
    }
    
    public String getPostalCode() {
        return this.postal_code;
    }
    
    public String getCity() {
        return this.city;
    }
    
    public String getProvince() {
        return this.province;
    }
}
