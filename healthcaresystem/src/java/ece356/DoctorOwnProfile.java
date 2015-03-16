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
public class DoctorOwnProfile {
    public enum Gender {
        M,
        F
    }
    
    private String user_alias;
    private String email;
    private String name_first;
    private String name_middle;
    private String name_last;
    private Gender gender;
    private Integer num_years_licensed;
    private Double avg_rating;
    private Integer num_reviews;
    
    public DoctorOwnProfile(String user_alias, String email, String name_first, String name_middle, String name_last, Gender gender, Integer num_years_licensed, Double avg_rating, Integer num_reviews) {
        this.user_alias = user_alias;
        this.email = email;
        this.name_first = name_first;
        this.name_middle = name_middle;
        this.name_last = name_last;
        this.gender = gender;
        this.num_years_licensed = num_years_licensed;
        this.avg_rating = avg_rating;
        this.num_reviews = num_reviews;
    }
    
    public String getUserAlias() {
        return this.user_alias;
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
    
    public Gender getGender() {
        return this.gender;
    }
    
    public Integer getNumYearsLicensed() {
        return this.num_years_licensed;
    }
    
    public Double getAvgRating() {
        return this.avg_rating;
    }
    
    public Integer getNumReviews() {
        return this.num_reviews;
    }
}
