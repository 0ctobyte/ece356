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
public class User {
    public enum AccountType {
        DOCTOR,
        PATIENT
    }
    
    private String user_alias;
    private String email;
    private String password_hash;
    private String name_first;
    private String name_middle;
    private String name_last;
    private AccountType account_type;
    
    public User(String user_alias, String email, String password_hash, String name_first, String name_middle, String name_last, AccountType account_type) {
        this.user_alias = user_alias;
        this.email = email;
        this.password_hash = password_hash;
        this.name_first = name_first;
        this.name_middle = name_middle;
        this.name_last = name_last;
        this.account_type = account_type;
    }
    
    public String getUserAlias() {
        return this.user_alias;
    }
    
    public String getEmail() {
        return this.email;
    }
    
    public String getPasswordHash() {
        return this.password_hash;
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
    
    public AccountType getAccountType() {
        return this.account_type;
    }
}
