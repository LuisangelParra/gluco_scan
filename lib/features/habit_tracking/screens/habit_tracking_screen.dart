import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gluco_scan/routes/app_routes.dart';
// Removed unused imports

/// Pantalla de Seguimiento de hábitos completamente funcional
class HabitTrackingScreen extends StatefulWidget {
  const HabitTrackingScreen({super.key});

  @override
  State<HabitTrackingScreen> createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  // Categoría seleccionada actualmente (null = todas)
  String? _selectedCategory;
  
  // Lista de hábitos
  final List<HabitItem> _habits = [
    HabitItem(
      title: '30 min de caminata ligera',
      subtitle: 'Actividad Física · Hoy',
      category: 'activity',
      icon: Icons.directions_run,
      backgroundColor: Colors.teal.shade50,
      iconColor: Colors.teal,
      isCompleted: true,
      quantity: '30 min',
    ),
    HabitItem(
      title: 'Comida: Ensalada + 1 fruta',
      subtitle: 'Alimentación Saludable · Hoy',
      category: 'nutrition',
      icon: Icons.eco_outlined,
      backgroundColor: Colors.green.shade50,
      iconColor: Colors.green,
      isCompleted: true,
      quantity: '1 fruta',
    ),
    HabitItem(
      title: 'Dormiste 7.5 horas',
      subtitle: 'Sueño · Hoy',
      category: 'sleep',
      icon: Icons.nightlight_round,
      backgroundColor: const Color(0xFF5956A6).withOpacity(0.1),
      iconColor: const Color(0xFF5956A6),
      isCompleted: true,
      quantity: '7.5 horas',
    ),
  ];

  // Controladores para el formulario de agregar hábito
  final TextEditingController _titleController = TextEditingController();
  String _newHabitCategory = 'activity';
  String _sleepHours = '';
  String _foodQuantity = '';
  String _activityType = '';

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar hábitos según la categoría seleccionada
    final filteredHabits = _selectedCategory == null
        ? _habits
        : _habits.where((habit) => habit.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF6665A9), // Color morado exacto de la imagen
      body: SafeArea(
        child: Column(
          children: [
            // Header con título, icono y botón de regreso
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF5956A6), size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Seguimiento',
                        style: TextStyle(
                          color: Color(0xFF5956A6),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'de hábitos',
                        style: TextStyle(
                          color: Color(0xFF5956A6),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF5956A6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xFF5956A6),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // Descripción
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: Text(
                'Visualiza y administra tus hábitos diarios de forma clara y motivadora.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Contenido principal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Tarjeta con tip de salud
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5956A6).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.nightlight_round,
                              color: Color(0xFF5956A6),
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Dormir al menos 7 horas mejora tu salud mental y física.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 15, // Tamaño de letra aumentado
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Categoría botones en fila
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCategoryButton(
                            icon: Icons.directions_run,
                            label: 'Actividad\nFísica',
                            color: Colors.teal,
                            category: 'activity',
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 10,
                          ),
                          _buildCategoryButton(
                            icon: Icons.restaurant_menu,
                            label: 'Alimentación\nSaludable',
                            color: Colors.black87,
                            category: 'nutrition',
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                            indent: 10,
                            endIndent: 10,
                          ),
                          _buildCategoryButton(
                            icon: Icons.nights_stay,
                            label: 'Sueño',
                            color: Color(0xFF5956A6),
                            category: 'sleep',
                          ),
                        ],
                      ),
                    ),
                    
                    // Lista de hábitos
                    Expanded(
                      child: filteredHabits.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              itemCount: filteredHabits.length,
                              itemBuilder: (context, index) {
                                final habit = filteredHabits[index];
                                return _buildHabitCard(habit);
                              },
                            ),
                    ),
                    
                    // Botones adicionales de Añadir Hábito
                    _buildAddHabitButton(),
                    
                    const SizedBox(height: 70), // Espacio para el botón flotante
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Botón flotante de Aprende
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 40,
        width: 150,
        margin: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          label: const Text(
            '¡Aprende!',
            style: TextStyle(
              color: Color(0xFF5956A6),
              fontWeight: FontWeight.bold,
              fontSize: 15, // Tamaño de letra aumentado
            ),
          ), onPressed: () => Get.toNamed(AppRoutes.learning),
        ),
      ),
    );
  }

  // Widget para mostrar mensaje cuando no hay hábitos
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.format_list_bulleted,
            size: 64, 
            color: Colors.white.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'No hay hábitos en esta categoría',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Añade uno nuevo usando el botón inferior',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Botón de categoría
  Widget _buildCategoryButton({
    required IconData icon,
    required String label,
    required Color color,
    required String category,
  }) {
    final isSelected = _selectedCategory == category;
    
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade300 : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategory = isSelected ? null : category;
          });
        },
        child: Row(
          children: [
            Icon(icon, color: color, size: 22), // Tamaño de icono aumentado
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 13, // Tamaño de letra aumentado
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tarjeta de hábito con funcionalidad
  Widget _buildHabitCard(HabitItem habit) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _habits.remove(habit);
        });
        
        // Mostrar mensaje de confirmación con opción de deshacer
        final snackBar = SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              const Text('Hábito eliminado'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Deshacer',
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                _habits.add(habit);
              });
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: GestureDetector(
        onTap: () => _showHabitDetails(habit),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: habit.backgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  habit.icon,
                  color: habit.iconColor,
                  size: 22, // Tamaño de icono aumentado
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16, // Tamaño de letra aumentado
                      ),
                    ),
                    if (habit.quantity != null && habit.quantity!.isNotEmpty) ...[
                      Text(
                        habit.quantity!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                    Text(
                      habit.subtitle,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14, // Tamaño de letra aumentado
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18, // Tamaño de icono aumentado
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Botón para añadir hábito
  Widget _buildAddHabitButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton.icon(
        onPressed: _showAddHabitDialog,
        icon: const Icon(
          Icons.add,
          color: Colors.black54,
          size: 24, // Tamaño de icono aumentado
        ),
        label: const Text(
          'Añadir hábito',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 16, // Tamaño de letra aumentado
          ),
        ),
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }

  // Diálogo para añadir un nuevo hábito
  void _showAddHabitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                'Añadir nuevo hábito',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Campo de título
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del hábito',
                        border: OutlineInputBorder(),
                      ),
                      maxLength: 50,
                    ),
                    const SizedBox(height: 16),
                    
                    // Selección de categoría
                    const Text(
                      'Categoría:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Radio buttons para categorías
                    _buildCategoryRadio(
                      title: 'Actividad Física',
                      value: 'activity',
                      groupValue: _newHabitCategory,
                      onChanged: (value) {
                        setState(() {
                          _newHabitCategory = value!;
                        });
                      },
                    ),
                    _buildCategoryRadio(
                      title: 'Alimentación Saludable',
                      value: 'nutrition',
                      groupValue: _newHabitCategory,
                      onChanged: (value) {
                        setState(() {
                          _newHabitCategory = value!;
                        });
                      },
                    ),
                    _buildCategoryRadio(
                      title: 'Sueño',
                      value: 'sleep',
                      groupValue: _newHabitCategory,
                      onChanged: (value) {
                        setState(() {
                          _newHabitCategory = value!;
                        });
                      },
                    ),
                  if (_newHabitCategory == 'sleep') ...[
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Cantidad de horas dormidas',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _sleepHours = value;
                        });
                      },
                    ),
                  ],
                  if (_newHabitCategory == 'nutrition') ...[
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Cantidad de comida (ej. 1 fruta, 1 ensalada)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _foodQuantity = value;
                        });
                      },
                    ),
                  ],
                  if (_newHabitCategory == 'activity') ...[
                    const SizedBox(height: 8),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Tipo de actividad física',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _activityType = value;
                        });
                      },
                    ),
                  ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.trim().isNotEmpty) {
                      _addNewHabit();
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5956A6),
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Widget de radio button para selección de categoría
  Widget _buildCategoryRadio({
    required String title,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
  }) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF5956A6),
      contentPadding: EdgeInsets.zero,
    );
  }

  // Método para añadir un nuevo hábito
  void _addNewHabit() {
    final newHabit = HabitItem(
      title: _titleController.text.trim(),
      subtitle: '${_getCategoryName(_newHabitCategory)} · Hoy',
      category: _newHabitCategory,
      icon: _getCategoryIcon(_newHabitCategory),
      backgroundColor: _getCategoryBackgroundColor(_newHabitCategory),
      iconColor: _getCategoryIconColor(_newHabitCategory),
      isCompleted: false,
      quantity: _newHabitCategory == 'sleep'
          ? _sleepHours
          : _newHabitCategory == 'nutrition'
              ? _foodQuantity
              : _activityType,
    );
    
    setState(() {
      _habits.add(newHabit);
      _titleController.clear();
    });
    
    // Mostrar confirmación personalizada
    _showCustomToast('Hábito añadido con éxito');
  }

  // Mostrar detalles del hábito
  void _showHabitDetails(HabitItem habit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: habit.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      habit.icon,
                      color: habit.iconColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      habit.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Categoría: ${_getCategoryName(habit.category)}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Estado: ${habit.isCompleted ? "Completado" : "Pendiente"}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Botón para marcar como completado/pendiente
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        habit.isCompleted = !habit.isCompleted;
                      });
                      Navigator.pop(context);
                      _showCustomToast(
                        habit.isCompleted
                            ? 'Hábito marcado como completado'
                            : 'Hábito marcado como pendiente',
                      );
                    },
                    icon: Icon(
                      habit.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                    ),
                    label: Text(
                      habit.isCompleted ? 'Completado' : 'Marcar como completado',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5956A6),
                    ),
                  ),
                  // Botón para eliminar
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _habits.remove(habit);
                      });
                      Navigator.pop(context);
                      _showCustomToast('Hábito eliminado');
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Eliminar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Método para navegar a la pantalla de aprendizaje
  void _navigateToLearning() {
    // Aquí se implementaría la navegación real
    _showCustomToast('Navegando a la sección de aprendizaje');
    
    // Código real sería algo como:
    // Navigator.pushNamed(context, AppRoutes.learning);
  }

  // Toast personalizado en lugar de SnackBar default
  void _showCustomToast(String message) {
    // Eliminamos cualquier toast anterior
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
    // Mostramos el nuevo toast personalizado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF5956A6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Métodos auxiliares para categorías
  String _getCategoryName(String category) {
    switch (category) {
      case 'activity':
        return 'Actividad Física';
      case 'nutrition':
        return 'Alimentación Saludable';
      case 'sleep':
        return 'Sueño';
      default:
        return 'Otro';
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'activity':
        return Icons.directions_run;
      case 'nutrition':
        return Icons.eco_outlined;
      case 'sleep':
        return Icons.nightlight_round;
      default:
        return Icons.check_circle;
    }
  }

  Color _getCategoryBackgroundColor(String category) {
    switch (category) {
      case 'activity':
        return Colors.teal.shade50;
      case 'nutrition':
        return Colors.green.shade50;
      case 'sleep':
        return const Color(0xFF5956A6).withOpacity(0.1);
      default:
        return Colors.blue.shade50;
    }
  }

  Color _getCategoryIconColor(String category) {
    switch (category) {
      case 'activity':
        return Colors.teal;
      case 'nutrition':
        return Colors.green;
      case 'sleep':
        return const Color(0xFF5956A6);
      default:
        return Colors.blue;
    }
  }
}

// NOTE: After changing the HabitItem constructor, perform a full restart (not hot reload) to avoid null-constructor mismatches.
/// Clase para representar un ítem de hábito
class HabitItem {
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  bool isCompleted;
  final String? quantity;

  HabitItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.isCompleted,
    this.quantity,
  });
}