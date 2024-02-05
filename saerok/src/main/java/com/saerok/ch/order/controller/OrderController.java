package com.saerok.ch.order.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.saerok.ch.order.model.dto.OrderList;
import com.saerok.ch.order.model.dto.OrderListDetail;
import com.saerok.ch.order.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;

    @Autowired
    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }
    //주문관련  
    @GetMapping("/orders")
    public String listOrders(Model model) {
        List<OrderList> orders = orderService.findAllOrderLists();
        model.addAttribute("orders", orders);
        return "order/orders"; 
    }
    
    @GetMapping("/orders/{orderId}")
    public String listOrderDetails(@PathVariable int orderId, Model model) {
        List<OrderListDetail> orderDetails = orderService.findOrderDetailsByOrderId(orderId);
        String orderStatus = orderService.findOrderStatusByOrderId(orderId); 

        model.addAttribute("orderDetails", orderDetails);
        model.addAttribute("orderStatus", orderStatus); 
        return "order/orderDetails"; 
    }
    
    @PostMapping("/orders/{orderId}/approve")
    public String approveOrder(@PathVariable int orderId) {
        orderService.updateOrderStatus(orderId, "승인");
        orderService.updateInventory(orderId);
        return "redirect:/orders/" + orderId;
    }

    @PostMapping("/orders/{orderId}/reject")
    public String rejectOrder(@PathVariable int orderId) {
        orderService.updateOrderStatus(orderId, "반려");
        return "redirect:/orders/" + orderId;
    }
    
    
}
