package test;

import java.util.stream.LongStream;

import org.apache.geode.cache.Region;
import org.apache.geode.cache.client.ClientCache;
import org.apache.geode.cache.client.ClientCacheFactory;
import org.apache.geode.cache.client.ClientRegionShortcut;

public class GeodeClient {

  private static final String LOCATOR = "instance-1.c.data-g2c.internal";

  private static final int LOCATOR_PORT = 10334;

  private static final String REGION_NAME = "testRegion";

  private static final long numEntries = 1_000_000;

  private void populateRegion(Region region) {
    LongStream.range(0, numEntries).forEach(i -> region.put(i, "value" + 0));
  }

  private void doTest() {
    ClientCacheFactory clientCacheFactory = new ClientCacheFactory();
    ClientCache clientCache = clientCacheFactory.addPoolLocator(LOCATOR, LOCATOR_PORT).create();
    Region clientRegion = clientCache.createClientRegionFactory(ClientRegionShortcut.PROXY).create(REGION_NAME);
    populateRegion(clientRegion);
  }

  public static void main(String args[]) {
    GeodeClient geodeClient = new GeodeClient();
    geodeClient.doTest();
  }
}
