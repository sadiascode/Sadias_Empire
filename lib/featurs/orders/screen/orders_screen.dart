import 'package:flutter/material.dart';
import '../../../common/app_state.dart';
import '../../../common/custom_color.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final role = AppState.currentRole;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        elevation: 0,
        title: Text(
          role == UserRole.buyer ? "MY ARMORY TRACK" : "FFL VERIFICATIONS",
          style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.8, fontSize: 16),
        ),
      ),
      body: ValueListenableBuilder<List<FirearmOrder>>(
        valueListenable: AppState.ordersNotifier,
        builder: (context, orders, child) {
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No transaction records found.",
                style: TextStyle(color: AppColors.textMuted),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return role == UserRole.buyer
                  ? _buildBuyerOrderCard(order)
                  : _buildSellerOrderCard(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildBuyerOrderCard(FirearmOrder order) {
    int activeStep = 0;
    if (order.status == "FFL Processing") activeStep = 1;
    if (order.status == "Background Check Pending") activeStep = 2;
    if (order.status == "Ready for Pickup") activeStep = 3;
    if (order.status == "Completed") activeStep = 4;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderId,
                style: const TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                order.date,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order.firearm.imageUrl,
                  height: 60,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 60,
                    width: 80,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image_not_supported, color: Colors.white54, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.firearm.name,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Caliber: ${order.firearm.caliber} | FFL Shipment",
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF334155), height: 1),
          const SizedBox(height: 16),
          const Text(
            "BACKGROUND CHECK PROGRESS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.5),
          ),
          const SizedBox(height: 12),
          // Progress steps indicators
          _buildProgressStepper(activeStep),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.secondary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getProgressInstructions(order.status),
                    style: const TextStyle(color: AppColors.textLight, fontSize: 11, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerOrderCard(FirearmOrder order) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${order.orderId}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: _getStatusColor(order.status)),
                ),
                child: Text(
                  order.status.toUpperCase(),
                  style: TextStyle(color: _getStatusColor(order.status), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Buyer: ${order.buyerName} (${order.buyerEmail})",
            style: const TextStyle(color: AppColors.textLight, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            "Weapon: ${order.firearm.name}",
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            "Assigned FFL Fulfill: ${order.fflDealer}",
            style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 16),
          // Action Buttons depending on status
          if (order.status == "FFL Processing")
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      AppState.updateOrderStatus(order.orderId, "Background Check Pending");
                    },
                    child: const Text("Initialize Background Check", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                  ),
                ),
              ],
            ),
          if (order.status == "Background Check Pending")
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      AppState.updateOrderStatus(order.orderId, "Ready for Pickup");
                    },
                    child: const Text("Verify & Approve Background Check", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                  ),
                ),
              ],
            ),
          if (order.status == "Ready for Pickup")
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
                    onPressed: () {
                      AppState.updateOrderStatus(order.orderId, "Completed");
                    },
                    child: const Text("Confirm Buyer Handover / Complete", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                  ),
                ),
              ],
            ),
          if (order.status == "Completed")
            Row(
              children: const [
                Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Text(
                  "Order Completed & FFL Logged",
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "FFL Processing":
        return Colors.blue;
      case "Background Check Pending":
        return Colors.amber;
      case "Ready for Pickup":
        return Colors.green;
      case "Completed":
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  Widget _buildProgressStepper(int activeStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepIndicator("Ordered", activeStep >= 0, activeStep == 0),
        _buildStepLine(activeStep >= 1),
        _buildStepIndicator("FFL Processing", activeStep >= 1, activeStep == 1),
        _buildStepLine(activeStep >= 2),
        _buildStepIndicator("NICS Check", activeStep >= 2, activeStep == 2),
        _buildStepLine(activeStep >= 3),
        _buildStepIndicator("Pickup", activeStep >= 3, activeStep == 3),
      ],
    );
  }

  Widget _buildStepIndicator(String label, bool isDone, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isActive
              ? AppColors.secondary
              : (isDone ? AppColors.primary : Colors.grey[800]),
          child: Icon(
            isDone ? Icons.check : Icons.radio_button_unchecked,
            size: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.secondary : (isDone ? Colors.white : AppColors.textMuted),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? AppColors.primary : Colors.grey[800],
      ),
    );
  }

  String _getProgressInstructions(String status) {
    switch (status) {
      case "FFL Processing":
        return "Order received by the seller. The seller is verifying inventory and preparing transfer documents.";
      case "Background Check Pending":
        return "Firearm has been prepared. State police/FBI NICS Background check in progress. Please check back later.";
      case "Ready for Pickup":
        return "Background check PASSED! Your weapon is ready at your chosen FFL Dealer. Bring your CCW Permit and State ID to pick up.";
      case "Completed":
        return "Handover successfully completed. Gun purchase log registered in BATFE ATF Form 4473 record book.";
      default:
        return "";
    }
  }
}
