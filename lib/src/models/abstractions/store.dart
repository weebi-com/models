abstract class AbstractStore {}

typedef MobxTicketsStoreCreator<T extends AbstractStore> = T Function();
