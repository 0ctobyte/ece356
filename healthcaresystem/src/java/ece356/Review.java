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
public class Review {
    public String name_first;
    public String name_last;
    public String patient_alias;
    public Integer star_rating;
    public String date;
    public String comments;
    
    public Review(String name_first, String name_last, String patient_alias, Integer star_rating, String date, String comments) {
        this.name_first = name_first;
        this.name_last = name_last;
        this.patient_alias = patient_alias;
        this.star_rating = star_rating;
        this.date = date;
        this.comments = comments;
    }
    
    public String getFirstName() {
        return this.name_first;
    }
    
    public String getLastName() {
        return this.name_last;
    }
    
    public String getPatientAlias() {
        return this.patient_alias;
    }
    
    public Integer getStarRating() {
        return this.star_rating;
    }
    
    public String getDate() {
        return this.date;
    }
    
    public String getComments() {
        return this.comments;
    }
}
