import 'package:flutter/material.dart';
import 'package:play_ground/models/Catalog.dart';
import 'package:play_ground/widgets/catalog_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({super.key,
     required this.catalog,
    required this.onSelectCatalog,
  });
  
  final Catalog catalog;
  final void Function(Catalog catalog) onSelectCatalog;

  String get complexityText {
    return catalog.complexity.name[0].toUpperCase() +
        catalog.complexity.name.substring(1);
  }

  String get affordabilityText {
    return catalog.affordability.name[0].toUpperCase() +
        catalog.affordability.name.substring(1);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectCatalog(catalog);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(catalog.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      catalog.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CatalogItemTrait(
                          icon: Icons.schedule,
                          label: '${catalog.duration} min',
                        ),
                        const SizedBox(width: 12),
                        CatalogItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        CatalogItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
