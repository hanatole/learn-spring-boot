package com.codewithmosh.store.controllers;

import com.codewithmosh.store.dtos.ProductDto;
import com.codewithmosh.store.entities.Product;
import com.codewithmosh.store.mappers.ProductMapper;
import com.codewithmosh.store.repositories.ProductRepository;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/product")
public class ProductController {
    private final ProductRepository productRepository;
    private final ProductMapper productMapper;

    @GetMapping
    public Iterable<ProductDto> getProducts
            (
                    @RequestHeader(required = false, name = "x-auth-token") String authToken,
                    @RequestParam(required = false, name = "categoryId") Byte categoryId) {
        System.out.println("The token is " + authToken);
        List<Product> products = categoryId == null ? productRepository.findAllWithCategory() : productRepository.findByCategoryId(categoryId);

        return products.stream().map(productMapper::toDto).toList();
    }

    @GetMapping("{id}")
    public ResponseEntity<ProductDto> getProduct(@PathVariable Long id) {
        var product = productRepository.findById(id).orElse(null);
        if (product == null)
            return ResponseEntity.notFound().build();
        return new ResponseEntity<>(productMapper.toDto(product), HttpStatus.OK);
    }
}
