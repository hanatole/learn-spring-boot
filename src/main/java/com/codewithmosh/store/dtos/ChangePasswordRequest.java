package com.codewithmosh.store.dtos;

import lombok.Data;

@Data
public class ChangePasswordRequest {
    private String password;
    private String oldPassword;
}
