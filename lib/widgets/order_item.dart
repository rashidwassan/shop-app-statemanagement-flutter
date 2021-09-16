import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final ord.OrderItem order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon((_isExpanded) ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                  height: min(widget.order.products.length * 20 + 10, 180),
                  child: ListView(
                    children: widget.order.products
                        .map((product) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${product.quantity}x \$${product.price}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                )
                              ],
                            ))
                        .toList(),
                  )),
            )
        ],
      ),
    );
  }
}
