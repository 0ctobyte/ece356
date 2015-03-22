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
public class PatientSearch {
    private String patient_alias;
    private String city;
    private String province;
    private Integer num_reviews;
    private String last_review;
    private String friend_alias;
    private Boolean accepted;
    
    public PatientSearch(String patient_alias, String city, String province, Integer num_reviews, String last_review, String friend_alias, Boolean accepted) {
        this.patient_alias = patient_alias;
        this.city = city;
        this.province = province;
        this.num_reviews = num_reviews;
        this.last_review = last_review;
        this.friend_alias = friend_alias;
        this.accepted = accepted;
    }
    
    public String getPatientAlias() {
        return this.patient_alias;
    }
    
    public String getCity() {
        return this.city;
    }
    
    public String getProvince() {
        return this.province;
    }
    
    public Integer getNumReviews() {
        return this.num_reviews;
    }
    
    public String getLastReview() {
        return this.last_review;
    }
    
    public String getFriendAlias() {
        return this.friend_alias;
    }
    
    public Boolean getAccepted() {
        return this.accepted;
    }
}
