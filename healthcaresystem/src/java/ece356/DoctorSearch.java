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
public class DoctorSearch {
    private String doctor_alias;
    private String name_first;
    private String name_middle;
    private String name_last;
    private Integer num_reviews;
    private Double avg_rating;
    
    public DoctorSearch(String doctor_alias, String name_first, String name_middle, String name_last, Integer num_reviews, Double avg_rating) {
        this.doctor_alias = doctor_alias;
        this.name_first = name_first;
        this.name_middle = name_middle;
        this.name_last = name_last;
        this.num_reviews = num_reviews;
        this.avg_rating = avg_rating;
    }
    
    public String getDoctorAlias() {
        return this.doctor_alias;
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
    
    public Double getAvgRating() {
        return this.avg_rating;
    }
}
